CREATE OR REPLACE TRIGGER adm_person.LDCTRGBUDI_OR_UIBM
  BEFORE UPDATE OR DELETE OR INSERT ON OR_UNI_ITEM_BALA_MOV
  REFERENCING OLD AS OLD NEW AS NEW
  FOR EACH ROW
/*  Propiedad intelectual de Gases de Occidente
      Trigger     :   LDCTRGBUDI_OR_UIBM
      Descripción :   Trigger para almacenar los materiales
                      de la tabla "OR_UNI_ITEM_BALA_MOV"
            separados en bodegas de Activos fijos e Inventarios.
      Autor       :   Juan C. Ramírez C. (Optima Consulting)
      Fecha       :   27-OCT-2014

      Historial de modificaciones
      Fecha            IDEntrega

      22-OCT-2014      jcramirez

      21-ENE-2015      ggamarra     Cambio 6021: Se eliminan los INSERT en  LDC_ITEMS_DOCUMENTO
                                                 Se coloca validacion de cantidad disponible en
                                                 cada bodega antes de trasladar
      22-JUL-2015	   Mmejia	    Cambio 8004: Se elimina la logica por gasera y se deja una unidad
												 de programa con la cual se realizaron pruebas de
												 traslados por GEITE-> traslados de items
       LJLB            14-nov-2018     200-2271 -- se aplica trigger de la entrega del caso
                                      930 para solucionar problema del release
                                      597, ademas se habilita control de las bodegas de inventario y activos
    16/01/2019        dsaltarin       200-2412 Se modifica para que mueva bodegas de activo/inventario cuadno
                                      se anula aceptación en sap. 
	  23/05/2019		  dsaltarin		  200-2470. Se detecta error de programa al aceptar con causal diferente al traslado	
									 cuando se acepta en una fecha diferente.
									 Se permite trasladar cuando no exista en a la bodega de activos o inventarios con cantidad y el valor es cero
    05/07/2023        felipe.valencia     Se elimina el mensaje de error errors.seterror(2741,
                                          'En la bodega NO existen INVENTARIO del [' ||
                                          :new.items_id || ']') y se agrega el item a inventario
    26/07/2023        felipe.valencia     Se elimina el mensaje de error errors.seterror(2741,
                                          'En la bodega NO existen ACTIVOS del [' ||
                                          :new.items_id || ']') y se agrega el item a inventario
    17/10/2024        lubin.pineda		OSF-3450: Se migra a ADM_PERSON     
  */
  --  when (OLD.balance <> NEW.balance)
Declare
  --Constantes
  csbtiboac Constant open.ldc_tt_tb.warehouse_type%Type := 'A'; --Tipo de bodega Activos
  csbtiboin Constant open.ldc_tt_tb.warehouse_type%Type := 'I'; --Tipo de bodega Inventarios
  csbTiBoGn Constant open.ldc_tt_tb.warehouse_type%Type := 'G'; --Tipo de bodega General -- CA200-930

  --Variables
  nuerrcode    open.ge_error_log.error_log_id%Type;
  sberrmsg     open.ge_error_log.description%Type;
  nuorderid    open.or_order.order_id%Type;
  rcldctttb    ldc_tt_tb%Rowtype;
  nusaldouo    open.or_ope_uni_item_bala.balance%Type;
  nuregafect   Number; --Numero de registros afectado
  nubalance    open.or_ope_uni_item_bala.balance%Type;
  total_costs  open.or_ope_uni_item_bala.total_costs%Type;
  nubalance2   open.or_ope_uni_item_bala.balance%Type;
  total_costs2 open.or_ope_uni_item_bala.total_costs%Type;
  nubalance3   open.or_ope_uni_item_bala.balance%Type;
  total_costs3 open.or_ope_uni_item_bala.total_costs%Type;

  nucostototal Number;

  nusupport  open.or_uni_item_bala_mov.id_items_documento%Type; --Documento de soporte de mov
  sbtibodega open.ldc_tt_tb.warehouse_type%Type;
  nusigno    Number := 1;
  nuFlagTrasladoInv number;
  nuFlagTrasladoAct number;

  --cursor para identificar si el item de la orden con el tipo de trabajo
  --esta configurado como ACTIVO o INVENTARIO
  Cursor cutipobodega(inuitemid  ge_items.items_id%Type,
                      inuorderid or_order.order_id%Type) Is
    Select Distinct ltt.*
      From open.ge_items i, open.or_order o, open.or_order_items oi, open.ldc_tt_tb ltt
     Where oi.items_id = i.items_id
       And o.order_id = oi.order_id
       And ltt.task_type_id = o.task_type_id
       And o.order_id = inuorderid;

  --cursor para determinar el proveedor logistico si es ACTIVO o INVENTARIO
  Cursor curactivoinventario(nudestino_oper_uni_id open.ge_items_documento.destino_oper_uni_id%Type) Is
    Select instr((Select casevalo
                   From open.ldci_carasewe
                  Where casecodi = 'LST_CENTROS_SOL_ACT'
                    And casedese = 'WS_TRASLADO_MATERIALES'),
                 nudestino_oper_uni_id) lst_centros_sol_act,
           instr((Select casevalo
                   From open.ldci_carasewe
                  Where casecodi = 'LST_CENTROS_SOL_INV'
                    And casedese = 'WS_TRASLADO_MATERIALES'),
                 nudestino_oper_uni_id) lst_centros_sol_inv
      From dual;

  tempcuractivoinventario curactivoinventario%Rowtype;

  --cursor para determinar el proveedor logistico si es ACTIVO o INVENTARIO
  Cursor cutrasladoitemsabierto(inuiditemsdoc open.or_uni_item_bala_mov.id_items_documento%Type) Is
    Select g1.*
      From open.ge_items_documento g1
     Where g1.operating_unit_id = :new.operating_unit_id
       And g1.destino_oper_uni_id <> g1.operating_unit_id
       And g1.estado = 'A'
       And trunc(g1.fecha) = trunc(Sysdate)
       And g1.causal_id Is Not Null
       And g1.id_items_documento = :new.id_items_documento
          --    and g1.id_items_documento =
          --        decode(inuIdItemsDoc, 0, g1.id_items_documento, inuIdItemsDoc)
       And g1.id_items_documento Not In
           (Select lid.id_items_documento
              From open.ldc_items_documento lid
             Where lid.id_items_documento = g1.id_items_documento);

  tempcutrasladoitemsabierto cutrasladoitemsabierto%Rowtype;

  --cursor para determinar el proveedor logistico si es ACTIVO o INVENTARIO
  Cursor cutrasladoitemscerrado(inuiditemsdoc or_uni_item_bala_mov.id_items_documento%Type) Is
    Select g1.*
      From open.ge_items_documento g1
     Where g1.operating_unit_id = :new.operating_unit_id
       And g1.destino_oper_uni_id = :new.operating_unit_id
       And g1.estado = 'C'
       And trunc(g1.fecha) = trunc(Sysdate)
       And g1.causal_id Is Not Null
       And g1.id_items_documento = :new.id_items_documento
          --  and g1.id_items_documento =
          --     decode(inuIdItemsDoc, 0, g1.id_items_documento, inuIdItemsDoc)
       And g1.id_items_documento Not In
           (Select lid.id_items_documento
              From open.ldc_items_documento lid
             Where lid.id_items_documento = g1.id_items_documento);

  tempcutrasladoitemscerrado cutrasladoitemscerrado%Rowtype;

  --cursor para determinar el proveedor logistico si es ACTIVO o INVENTARIO en rechazo
  Cursor cutrasladoitemscerrrech(inuiditemsdoc open.or_uni_item_bala_mov.id_items_documento%Type) Is
    Select g1.*
      From open.ge_items_documento g1
     Where g1.operating_unit_id <> :new.operating_unit_id
       And g1.destino_oper_uni_id = :new.operating_unit_id
       And g1.estado = 'C'
       And trunc(g1.fecha) = trunc(Sysdate)
       And g1.causal_id Is Not Null
       And g1.id_items_documento = :new.id_items_documento
          --  and g1.id_items_documento =
          --     decode(inuIdItemsDoc, 0, g1.id_items_documento, inuIdItemsDoc)
       And g1.id_items_documento Not In
           (Select lid.id_items_documento
              From open.ldc_items_documento lid
             Where lid.id_items_documento = g1.id_items_documento);

  tempcutrasladoitemscerrrech cutrasladoitemscerrrech%Rowtype;

  --valida si existe el resgitro en activo
  Cursor cuexiteldc_act_ouib Is
    Select *
      From open.ldc_act_ouib lao
     Where lao.items_id = :new.items_id
       And lao.operating_unit_id = :new.operating_unit_id;

  tempcuexiteldc_act_ouib cuexiteldc_act_ouib%Rowtype;

  --valida si existe el resgitro en inventario
  Cursor cuexiteldc_inv_ouib Is
    Select *
      From open.ldc_inv_ouib lao
     Where lao.items_id = :new.items_id
       And lao.operating_unit_id = :new.operating_unit_id;

  tempcuexiteldc_inv_ouib cuexiteldc_inv_ouib%Rowtype;

  --Obtiene datos de la empresa
  Cursor cusistema Is
    Select * From sistema;

  rccusistema cusistema%Rowtype;

  --cursor obtiene los datos del documento
  Cursor cuobtienedatdocu(inuiditemsdoc open.or_uni_item_bala_mov.id_items_documento%Type) Is
    Select g1.*
      From open.ge_items_documento g1
     Where g1.destino_oper_uni_id = g1.destino_oper_uni_id --:new.operating_unit_id
       --And trunc(g1.fecha) = trunc(Sysdate) --200-2470 Se coloca en comenario para que oblique que sea la misma causal
       And g1.causal_id Is Not Null
       And g1.id_items_documento = inuiditemsdoc --:new.id_items_documento
       And g1.id_items_documento Not In
           (Select lid.id_items_documento
              From open.ldc_items_documento lid
             Where lid.id_items_documento = g1.id_items_documento);


  rccuobtienedatdocuuno cuobtienedatdocu%Rowtype;
  rccuobtienedatdocudos cuobtienedatdocu%Rowtype;

  --Cursor que Valida si la casual es de inventario  o de traslado
  Cursor cuvalcausal(nucausal open.ge_causal.causal_id%Type) Is
    Select causal_id, csbtiboin tipo
      From open.ge_causal
     Where causal_id In
           (Select to_number(column_value)
              From Table(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('CODIGO_TRASLADO_INVENTARIO',
                                                                                       Null),
                                                      ',')))
       And causal_id = nucausal
    Union
    Select causal_id, csbtiboac tipo
      From open.ge_causal
     Where causal_id In
           (Select to_number(column_value)
              From Table(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('CODIGO_TRASLADO_ACTIVO',
                                                                                       Null),
                                                      ',')))
       And causal_id = nucausal
    --INICIO CA200-930
       UNION
      SELECT causal_id, csbTiBoGn TIPO
      FROM  open.GE_CAUSAL
      WHERE  causal_id IN
                    ( SELECT TO_NUMBER(COLUMN_VALUE)
                       FROM TABLE
                        (open.LDC_BOUTILITIES.SPLITSTRINGS(
                            open.DALD_PARAMETER.fsbGetValue_Chain('CODIGO_TRASLADO_GENERAL',NULL),',')
                        )
                    )
      AND causal_id = nuCausal;
      --FIN CA200-930

  rccuvalcausal cuvalcausal%Rowtype;

  nuiditemsdoc     open.or_uni_item_bala_mov.id_items_documento%Type;
  nuiditemsseriado open.or_uni_item_bala_mov.id_items_seriado%Type;
  sbestadoinv      open.or_uni_item_bala_mov.id_items_estado_inv%Type;
  nuvalorventa     open.or_uni_item_bala_mov.valor_venta%Type;
  nuoperunittarget open.or_uni_item_bala_mov.target_oper_unit_id%Type;
  nuinitstatus     open.or_uni_item_bala_mov.init_inv_stat_items%Type;

  --200-2412
  Cursor cuobtieneCausalAnulDevol(inuiditemsdoc or_uni_item_bala_mov.id_items_documento%Type) Is
    Select orig.causal_id
      From open.ge_items_documento g1, open.ldci_intemmit,open.ge_items_documento orig
     Where g1.destino_oper_uni_id = g1.destino_oper_uni_id --:new.operating_unit_id
       And trunc(g1.fecha) = trunc(Sysdate)
       And g1.id_items_documento = inuiditemsdoc
       And 'AUTO_'||mmitdsap=g1.documento_externo
       and to_number(mmitnudo)=orig.id_items_documento;

  nuCausaDev open.ge_causal.causal_id%type;
  sbEntrega2002412 	open.ldc_versionentrega.nombre_entrega%type:='OSS_OYM_DSS_2002412_1';
  sbTraslado2470	open.ld_parameter.value_chain%type:=nvl(open.dald_parameter.fsbGetValue_Chain('LDPERMITETRASLADOGENERAL',null),'N');
  sbValCaus2470	open.ld_parameter.value_chain%type:=nvl(open.dald_parameter.fsbGetValue_Chain('VALIDA_CAUSAL_TRASLADO_ALMACEN',null),'N'); 
  
  Cursor cuCentroLog is 
	select 'A' TIPO, CASEVALO centro
	from open.LDCI_CARASEWE
	where  CASEDESE='WS_TRASLADO_MATERIALES'
	AND CASECODI IN ('LST_CENTROS_SOL_ACT')
	UNION ALL
	select 'I' TIPO, CASEVALO centro
	from open.LDCI_CARASEWE
	where  CASEDESE='WS_TRASLADO_MATERIALES'
	AND CASECODI IN ('LST_CENTROS_SOL_INV');
	
	rgCentroLog cuCentroLog%rowtype;
Begin

  Open cusistema;
  Fetch cusistema
    Into rccusistema;
  Close cusistema;

  ut_trace.trace('inicio LDCTRGBUDI_OR_UIBM', 10 );

  --Valida que el documento no sea nulo y que las causas de movimientos sean
  --(16)Entrada por Aceptacion -> se crea cuando realiza la aceptacion del traslado
  --(17)Entrada por Reclamo -> ae crea cuando se rechaza un traslado
  --(20)Transito -> se crea cuando se crea el traslado o existe transito se items
  ut_trace.trace(':new.id_items_documento : ' || :new.id_items_documento || ' :new.item_moveme_caus_id: ' || :new.item_moveme_caus_id , 10 );
  If (:new.id_items_documento Is Not Null And
     :new.item_moveme_caus_id In (16, 17, 20)) Then
     ut_trace.trace('entro if ', 10 );
    --Obtiene el documento principal del documento
    Open cuobtienedatdocu(:new.id_items_documento);
    Fetch cuobtienedatdocu
      Into rccuobtienedatdocuuno;
    Close cuobtienedatdocu;

    --Valida si el documento de soporte no es nulo
    If (substr(:new.support_document, 0, 15) Is Not Null) Then
    ut_trace.trace('entro if 2', 10 );
      Begin
        nusupport := nvl(to_number(substr(:new.support_document, 0, 15)),
                         0);
        ut_trace.trace('nusupport : ' || nusupport , 10);
      Exception
        When Others Then
          nusupport := 0;
           ut_trace.trace('error if 2', 10 );
      End;

      --Obtiene el documento principal del documento
      Open cuobtienedatdocu(nusupport);
      Fetch cuobtienedatdocu
        Into rccuobtienedatdocudos;
      Close cuobtienedatdocu;
    ut_trace.trace('rccuobtienedatdocudos.causal_id : ' || rccuobtienedatdocudos.causal_id || 'rccuobtienedatdocuuno.causal_id : ' ||rccuobtienedatdocuuno.causal_id , 10);
      --Valida que la causal de traslado sea la misma de aceptacion
      If (rccuobtienedatdocudos.causal_id <>
         rccuobtienedatdocuuno.causal_id And nusupport <> 0) Then
          ut_trace.trace('La causal de aceptacion debe ser la misma que la causal de traslado', 10 );
        errors.seterror(2741,
                        'La causal de aceptacion debe ser la misma que la causal de traslado ');
        Raise ex.controlled_error;
      End If;

    End If; --Valida SUPPORT_DOCUMENT

    --Valida la causal del documento de traslado
    Open cuvalcausal(rccuobtienedatdocuuno.causal_id);
    Fetch cuvalcausal
      Into rccuvalcausal;
    Close cuvalcausal;
    --200-2412 si es una anulación de devolución se busca la devolución original para validar el tipo de causal
    if rccuobtienedatdocuuno.causal_id is null and :new.item_moveme_caus_id In (16) then
        open cuobtieneCausalAnulDevol(:new.id_items_documento);
        fetch cuobtieneCausalAnulDevol into nuCausaDev;
        if cuobtieneCausalAnulDevol%found then
           Open cuvalcausal(nuCausaDev);
           Fetch cuvalcausal
              Into rccuvalcausal;
           Close cuvalcausal;
        end if;
        close cuobtieneCausalAnulDevol;
    end if;
    --200-2412 si es una anulación de devolución se busca la devolución original para validar el tipo de causal

    --Se asigan el tipo de bodega que corresponde la causal
    sbtibodega := rccuvalcausal.tipo;
    ut_trace.trace('sbtibodega :' || sbtibodega , 10);
	
	IF sbValCaus2470 = 'S' THEN
		IF :new.item_moveme_caus_id In (20) AND OPEN.DAOR_OPERATING_UNIT.FNUGETOPER_UNIT_CLASSIF_ID(:NEW.TARGET_OPER_UNIT_ID)=11 THEN
			for reg in  cuCentroLog loop
				if instr(reg.centro,:NEW.TARGET_OPER_UNIT_ID) >0 and reg.TIPO!=sbtibodega then
					errors.seterror(2741, 'El tipo de almacen a donde va a devolver no corresponde con la causal de devoluciÃ³n, favor validar.');
					raise ex.controlled_error;
				end if;
			end loop;
			
		END IF;
	END IF;


    --INICIO CA200-930
    if (LDC_CONFIGURACIONRQ.aplicaParaEfigas('OSS_CON_CAF_200930')
          or LDC_CONFIGURACIONRQ.aplicaParaSurtigas('OSS_CON_CAF_200930')
          or LDC_CONFIGURACIONRQ.aplicaParaGDC('OSS_CON_CAF_200930')
          or LDC_CONFIGURACIONRQ.aplicaParaGDO('OSS_CON_CAF_200930')) AND (sbtibodega = 'G') then


        select count(1)
        INTO nuFlagTrasladoAct
         from open.LDC_ACT_OUIB
        where ldc_act_ouib.items_id = :new.items_id
           and ldc_act_ouib.operating_unit_id IN (:new.operating_unit_id, :new.target_oper_unit_id);


        select count(1)
        INTO nuFlagTrasladoInv
         from open.ldc_inv_ouib
        where ldc_inv_ouib.items_id = :new.items_id
           and ldc_inv_ouib.operating_unit_id IN (:new.operating_unit_id, :new.target_oper_unit_id);

        IF (nuFlagTrasladoAct > 0 OR nuFlagTrasladoInv > 0)  THEN
          errors.seterror(2741, 'Uno o más ítems de este traslado existen en las bodegas de activo o inventario para la unidad operativa origen o unidad operativa destino. Revisa la causal utilizada o los ítems a trasladar');
          raise ex.controlled_error;
        END IF;

    --200-2470
	elsif sbTraslado2470='S' AND (sbtibodega = 'G') then
		select count(1)
        INTO nuFlagTrasladoAct
         from open.LDC_ACT_OUIB
        where ldc_act_ouib.items_id = :new.items_id
           and ldc_act_ouib.operating_unit_id IN (:new.operating_unit_id, :new.target_oper_unit_id)
		   and balance>0;


        select count(1)
        INTO nuFlagTrasladoInv
         from open.ldc_inv_ouib
        where ldc_inv_ouib.items_id = :new.items_id
           and ldc_inv_ouib.operating_unit_id IN (:new.operating_unit_id, :new.target_oper_unit_id)
		   and balance>0;

        IF (nuFlagTrasladoAct > 0  OR nuFlagTrasladoInv > 0 or :new.total_value>0)  THEN
          errors.seterror(2741, 'Uno o más ítems de este traslado existen en las bodegas de activo o inventario para la unidad operativa origen o unidad operativa destino. Revisa la causal utilizada o los ítems a trasladar');
          raise ex.controlled_error;
        END IF;
	end if;
    --FIN CA200-930

    --Valida que el movimiento aumente o disminuye
    If (:new.movement_type In ('D', 'I')) Then
      --Valida si el movimiento disminuye
      ut_trace.trace(':new.movement_type : ' || :new.movement_type , 10);
      If (:new.movement_type In ('D')) Then
        nusigno := -1;
      End If;
    ut_trace.trace('nusigno : ' || nusigno , 10);
      --Valida si la causal es de tipo de bodega Activo
      If sbtibodega = csbtiboac Then
        --Obtiene datos de labodega del activo
        ut_trace.trace('sbtibodega : ' || sbtibodega || ' =  csbtiboac : ' || csbtiboac  , 10);
        Open cuexiteldc_act_ouib;
        Fetch cuexiteldc_act_ouib
          Into tempcuexiteldc_act_ouib;
        --Valida que el cursor sea valido
        If cuexiteldc_act_ouib%Found Then
          --Valida que el movimiento sobre el balance es positivo
          ut_trace.trace(nvl(tempcuexiteldc_act_ouib.balance,0) || ' + ( '||nvl(:new.amount,0)||' * '||nvl(nusigno,0) ||')' , 10 );
          If ((nvl(tempcuexiteldc_act_ouib.balance,0) + (nvl(:new.amount,0) * nvl(nusigno,0))) >= 0) Then
            ut_trace.trace('Update ldc_act_ouib' , 10);
            Update ldc_act_ouib
               Set balance     = nvl(balance,0) + (nvl(:new.amount,0) * nvl(nusigno,0)),
                   total_costs = nvl(total_costs,0) + (nvl(:new.total_value,0) * nvl(nusigno,0))
             Where items_id = :new.items_id
               And operating_unit_id = :new.operating_unit_id;
          Else
            --ljlb 200-2271 --se habilita control
            ut_trace.trace('En la bodega de activos no existen suficientes unidades' , 10);
            errors.seterror(2741,'En la bodega de activos no existen suficientes unidades');
            Raise ex.controlled_error;
          End If;
        Else
          ut_trace.trace('En la bodega NO existen ACTIVOS del [' ||
                          :new.items_id || ']', 10 );

          IF (cuexiteldc_act_ouib%ISOPEN) THEN
            Close cuexiteldc_act_ouib;
          END IF;
          
          insert into ldc_act_ouib
          (
            items_id,
            operating_unit_id,
            quota,
            balance,
            total_costs,
            occacional_quota,
            transit_in,
            transit_out
          )
          values (
            :new.items_id,
            :new.operating_unit_id,
            nvl(:new.amount,0),
            nvl(:new.amount,0) ,
            (nvl(:new.total_value,0) * nvl(nusigno,0)), 
            0,
            0,
            0
          );
        End If;

        IF (cuexiteldc_act_ouib%ISOPEN) THEN
          Close cuexiteldc_act_ouib;
        END IF;
        ut_trace.trace('fin Valida tipode bodega activo' , 10);
      End If; --Valida tipode bodega activo

      --Valida si la causal es de tipo de bodega Inventario
      If sbtibodega = csbtiboin Then
        ut_trace.trace('sbtibodega : ' || sbtibodega || 'csbtiboin ' || csbtiboin , 10);
        --Obtiene datos de la bodega del Inventario
        Open cuexiteldc_inv_ouib;
        Fetch cuexiteldc_inv_ouib
          Into tempcuexiteldc_inv_ouib;

        --Valida que el cursor sea valido
        If cuexiteldc_inv_ouib%Found Then
          ut_trace.trace('entro if 4', 10 );
          --Valida que el movimiento sobre el balance es positivo
         -- ldc_proccrearegsergprograma(1,'83877546','entro if 4',sysdate);
       --   ldc_proccrearegsergprograma(2,'83877546',:new.operating_unit_id||' '||tempcuexiteldc_inv_ouib.balance || ' + (' || :new.amount || ' * ' || nusigno || ')) >= 0',sysdate);
          If ((nvl(tempcuexiteldc_inv_ouib.balance,0) + (nvl(:new.amount,0) * nvl(nusigno,0))) >= 0) Then
             ut_trace.trace( tempcuexiteldc_inv_ouib.balance || ' + (' || :new.amount || ' * ' || nusigno || ')) >= 0', 10 );
             ut_trace.trace( 'update ldc_inv_ouib' , 10);
           /*ut_trace.trace('Update ldc_inv_ouib
               Set balance     = '|| (:new.amount * nusigno) || ',
               total_costs = ' || total_costs + (:new.total_value * nusigno)
                || ' Where items_id = ' || :new.items_id ||
                'And operating_unit_id = ' || :new.operating_unit_id || ';'  );*/
           /* ldc_proccrearegsergprograma(3,83877546, substr('Update ldc_inv_ouib
               Set balance     = nvl(balance,0)|| + (nvl('||:new.amount||',0) * nvl('||nusigno||'||,0)),
                   total_costs = nvl(total_costs,0)|| + (nvl('||:new.total_value||',0)||' * '||nvl(nusigno,0))
             Where items_id = '||:new.items_id||'
               And operating_unit_id = '||:new.operating_unit_id,1,4000),sysdate);   */
            Update ldc_inv_ouib
               Set balance     = nvl(balance,0) + (nvl(:new.amount,0) * nvl(nusigno,0)),
                   total_costs = nvl(total_costs,0) + (nvl(:new.total_value,0) * nvl(nusigno,0))
             Where items_id = :new.items_id
               And operating_unit_id = :new.operating_unit_id;
          Else
            --ljlb 200-2271 --se habilita control
            ut_trace.trace('En la bodega de inventarios no existen suficientes unidades' , 10);
            errors.seterror(2741,
                            'En la bodega de inventarios no existen suficientes unidades');
            Raise ex.controlled_error;
          End If;

        Else
          ut_trace.trace('En la bodega NO existen INVENTARIOS del [' ||
                          :new.items_id || ']' , 10);

          IF (cuexiteldc_inv_ouib%ISOPEN) THEN
            Close cuexiteldc_inv_ouib;
          END IF;
          

          insert into ldc_inv_ouib
          (
            items_id,
            operating_unit_id,
            quota,
            balance,
            total_costs,
            occacional_quota,
            transit_in,
            transit_out
          )
          values (
            :new.items_id,
            :new.operating_unit_id,
            nvl(:new.amount,0),
            nvl(:new.amount,0) ,
            (nvl(:new.total_value,0) * nvl(nusigno,0)), 
            0,
            0,
            0
          );

        End If;
          IF (cuexiteldc_inv_ouib%ISOPEN) THEN
            Close cuexiteldc_inv_ouib;
          END IF;
        ut_trace.trace('fin Valida tipode bodega inventario' , 10);
      End If; --Valida tipode bodega inventario
      ut_trace.trace('fin Valida que el movimiento aumente o disminuye' , 10);
    End If; --Valida que el movimiento aumente o disminuye
   --;
  ut_trace.trace('fin Validacion id_items_documento no nulo y causas de movimiento.' , 10);
  End If; --Validacion id_items_documento no nulo y causas de movimiento.
Exception
  When ex.controlled_error Then
    Raise;
  When Others Then
    errors.seterror;
    Raise ex.controlled_error;
End ldctrgbudi_or_uibm;
/
