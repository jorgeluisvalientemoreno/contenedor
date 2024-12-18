CREATE OR REPLACE TRIGGER adm_person.LDCTRGBUDI_OR_OUIB
  BEFORE UPDATE OR DELETE OR INSERT ON OR_OPE_UNI_ITEM_BALA
  REFERENCING OLD AS OLD NEW AS NEW
  FOR EACH ROW
Declare
  /*  Propiedad intelectual de Gases de Occidente
      Trigger     :   LDCTRGBUDI_OR_OUIB
      Descripción :   Trigger para almacenar los materiales
                      de la tabla "OR_OPE_UNI_ITEM_BALA"
            separados en bodegas de Activos fijos e Inventarios.
      Autor       :   Juan C. Ramírez C. (Optima Consulting)
      Fecha       :   27-OCT-2014

      Historial de modificaciones
      Fecha            IDEntrega
      22-OCT-2014      jcramirez
      22-sep-2016  bcamargo
      Autor            Fecha           Descripcion
      ------          --------        ---------------------------------
      Sandra Muñoz    12-02-2015      CA100-8710
                                      * Cuando la existencia en bodega del contratista sea cero,
                                      se debe emplear la siguiente fórmula para calcular el costo
                                      total de las existencias del activo ó inventario:
                                      Costo total = costo total activo(ó inventario) ó (costo
                                      actual de la bodega del contratista ó nuevo costo de la bodega
                                      del contratista.
                                      * Validar que el tipo de trabajo de la orden de trabajo
                                      que se está actualizando está parametrizada en la tabla
                                      LDC_TT_TB, sino no se puede dejar realizar la modificación
      Sandra Muñoz    09-12-2015      ARA8732. Sólo funciona para cuando se está modificando la cantidad
                                      desde AIOSA, o MIOSA.
      Manuel Mejia    26/03/2015      Se modifica la logica del UPDATING para que tenga en cuenta en el cursor cudocumentopedido
                                      tambien el campo id_items_documento ya que solo se validaba  mmitnudo y para las ventas
                                      este camnpo no se llena en la interfaz. Para el caso de la anulacion se crea un cursor
                                      cuexistenciaAnulacion del cual sse usa para validar que el documento creado en la instancia
                                      sea de tipo anulacion, cuando le movimiento es de tipo cuexistencia  en las bodegas se suma este
                                      valor pero cuando es una anulacion se resta.
                                      Esta modificacion contiene la solucion del aranda 6360 y  6358.
      Gabriel Gamarra 21/01/2015      Cambio 6021 : Se insertan activos e inventarios en cero
      Jorge Valiene   26/11/2014      En conversacion con e lIng. Milton Eduardo se establecieron 3
                                      nuevos casos para el manejo de item en IFRS
                                      Caso 1.
                                      AL legalizar una orden con un tipo de trabajo configuracdo para
                                      mover items se debe actualizar COSTO TOTAL DE LOS ITEMS tanto en
                                      la entidad ACTIVO con en la de INVENTARIO de las entidades
                                      Se modifica el cursor para evitar la mutacion en el trigger. ya que para el proceso UPDATE
                                      esta generando un error
   jjjm
   LJLB            14-nov-2018     200-2271 -- se aplica trigger de la entrega
                                      OSS_CON_MAL_200833_1 para solucionar problema del release
                                      597
   daltarin		    05/03/2019	   200-2470 Se modifica para que si no hay existencias en activo/inventario y el valor legalizado es cero no arroje error.

   jvaliente      25/09/2021     CAMBIO 860 Crear nuevo CURSOR con la logica del cursor cudocumentopedido adciionando un busqueda de la cadena AUTO_.
	jpinedc			17/10/2024		OSF-3450: Se migra a ADM_PERSON
  */

  --Constantes
  csbtiboac Constant open.ldc_tt_tb.warehouse_type%Type := 'A'; --Tipo de bodega Activos
  csbtiboin Constant open.ldc_tt_tb.warehouse_type%Type := 'I'; --Tipo de bodega Inventarios
  --Variables
  nuerrcode   open.ge_error_log.error_log_id%Type;
  sberrmsg    open.ge_error_log.description%Type;
  nuorderid   open.or_order.order_id%Type;
  rcldctttb   open.ldc_tt_tb%Rowtype;
  nusaldouo   open.or_ope_uni_item_bala.balance%Type;
  nuregafect  Number; --Número de registros afectado
  nubalance   open.or_ope_uni_item_bala.balance%Type;
  total_costs open.or_ope_uni_item_bala.total_costs%Type;
  nucostototal Number;

  -- ARA8732
  sborden_id Varchar(4000);

  -- CA100-8710
  nusaldoco           open.ldc_act_ouib.total_costs%Type; -- Costo total en el activo o inventario
  nucantactinv        open.ldc_act_ouib.balance%Type; -- Nueva cantidad para el activo o inventario
  nuvaloractinv       open.ldc_act_ouib.total_costs%Type; -- Nuevo valor para el activo o el inventario
  sbsolomodificacosto Char(1); -- Identifica si Sólo se está modificando el costo

  --cursor para identificar si el item de la orden con el tipo de trabajo
  --esta configurado como ACTIVO o INVENTARIO

  Cursor cutipobodega(inuitemid  open.ge_items.items_id%Type,
                      inuorderid open.or_order.order_id%Type) Is
    Select Distinct ltt.*
      From open.ge_items i, open.or_order o, open.or_order_items oi, open.ldc_tt_tb ltt
     Where oi.items_id = i.items_id
       And o.order_id = oi.order_id
       And ltt.task_type_id = o.task_type_id
       And o.order_id = inuorderid;

  --cursor para saber el documento de pedido realizado a SAP
  Cursor cudocumentopedido(inuid_items_documento open.ge_items_documento.id_items_documento%Type) Is
    Select mmitnudo, g2.id_items_documento
      From open.ldci_intemmit, open.ge_items_documento g2
     Where instr((Select g1.documento_externo
                   From open.ge_items_documento g1
                  Where g1.id_items_documento = inuid_items_documento
                    And document_type_id In
                        (Select to_number(column_value)
                           From Table(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('COD_TIPO_DOC_DES_SAP',Null),
                                                                        ',')))),
                 mmitdsap) > 0
       And g2.id_items_documento = inuid_items_documento;

  tempcudocumentopedido cudocumentopedido%Rowtype;

  --cursor para validar la Recepción de Materiales de una compra
  --de materiales que viene del proveedor Logístico (SAP) la cual
  --Aplica en OR_OPE_UNI_ITEM_BALA y en GE_ITEMS_SERIADO

  Cursor cuexistencia(nuid_items_documento ge_items_documento.id_items_documento%Type) Is
    Select destino_oper_uni_id provedor_logistico
      From open.ge_items_documento
     Where id_items_documento = nuid_items_documento
       And document_type_id In
           (Select to_number(column_value)
              From Table(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('COD_TIPO_DOC_PED_SAP',Null),
                                                           ',')))

     Group By destino_oper_uni_id;

  tempcuexistencia cuexistencia%Rowtype;

  --Cursor que valida la existencia de un venta de material
  Cursor cuexistenciaventa(nuid_items_documento open.ge_items_documento.id_items_documento%Type) Is
    Select Case
             When g2.document_type_id = 101 Then
              g2.operating_unit_id
             When g2.document_type_id = 102 Then
              g2.destino_oper_uni_id
           End provedor_logistico
      From open.ge_items_documento g1, open.ge_items_documento g2
     Where g1.id_items_documento = nuid_items_documento
       And g2.document_type_id In
           (Select to_number(column_value)
              From Table(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('COD_TIPO_DOC_PED_SAP',Null),
                                                           ',')))
       And g1.documento_externo = g2.documento_externo
     Group By g2.destino_oper_uni_id,
              g2.document_type_id,
              g2.operating_unit_id;

  tempcuexistenciaventa cuexistenciaventa%Rowtype;

  --Valida si existe una anulacion desde SAP

  Cursor cuexistenciaanulacion(nuid_items_documento open.ge_items_documento.id_items_documento%Type) Is
    Select Case
             When g2.document_type_id = 104 Then
              g2.destino_oper_uni_id
           End provedor_logistico
      From open.ge_items_documento g1, open.ge_items_documento g2
     Where g1.id_items_documento = nuid_items_documento
       And g2.document_type_id In
           (Select to_number(column_value)
              From Table(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('COD_TIPO_DOC_ANU_SAP',Null),
                                                           ',')))
       And g1.documento_externo = g2.documento_externo
     Group By g2.destino_oper_uni_id,
              g2.document_type_id,
              g2.operating_unit_id;

  tempcuexistenciaanulacion cuexistenciaanulacion%Rowtype;

  --cursor para determinar el proveedor logistico si es ACTIVO o INVENTARIO

  Cursor curactivoinventario(nudestino_oper_uni_id open.ge_items_documento.destino_oper_uni_id%Type) Is
    Select instr((Select casevalo
                   From open.ldci_carasewe
                  Where casecodi = 'LST_CENTROS_SOL_ACT'
                       --and casedese = 'WS_TRASLADO_MATERIALES'),
                    And casedese = 'WS_RESERVA_MATERIALES'),
                 nudestino_oper_uni_id) lst_centros_sol_act,
           instr((Select casevalo
                   From open.ldci_carasewe
                  Where casecodi = 'LST_CENTROS_SOL_INV'
                       --and casedese = 'WS_TRASLADO_MATERIALES'),
                    And casedese = 'WS_RESERVA_MATERIALES'),
                 nudestino_oper_uni_id) lst_centros_sol_inv
      From dual;

  tempcuractivoinventario curactivoinventario%Rowtype;

  --Cursor para determinar un traslado de items abierto

  Cursor cutrasladoitemsabierto(inuiditemsdoc open.or_uni_item_bala_mov.id_items_documento%Type) Is
    Select g1.*
      From ge_items_documento g1
     Where g1.operating_unit_id = :new.operating_unit_id
       And g1.fecha = --trunc(sysdate)
           (Select Max(g.fecha)
              From ge_items_documento g
             Where g.operating_unit_id = g1.operating_unit_id
            --or g.destino_oper_uni_id = g1.destino_oper_uni_id)
            )
       And g1.estado = 'A'
       And trunc(g1.fecha) = trunc(Sysdate)
       And g1.id_items_documento = inuiditemsdoc
       And g1.document_type_id In
           (Select to_number(column_value) column_value
              From Table(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('CODIGO_DOC_ITIEM_TRASLADO',Null),
                                                      ','))); --Tipo documento traslado de items

  tempcutrasladoitemsabierto cutrasladoitemsabierto%Rowtype;

  --Cursor para determinar un traslado de items Cerrado

  Cursor cutrasladoitemscerrado(inuiditemsdoc open.or_uni_item_bala_mov.id_items_documento%Type) Is
    Select g1.*
      From open.ge_items_documento g1
     Where --(g1.operating_unit_id = :new.operating_unit_id or
     g1.destino_oper_uni_id = :new.operating_unit_id
     And g1.fecha = --trunc(sysdate)
     (Select Max(g.fecha)
        From open.ge_items_documento g
       Where --(g.operating_unit_id = g1.operating_unit_id or
       g.destino_oper_uni_id = g1.destino_oper_uni_id)
     And g1.estado = 'C'
     And g1.id_items_documento = inuiditemsdoc
     And trunc(g1.fecha) = trunc(Sysdate)
     And g1.document_type_id In
     (Select to_number(column_value) column_value
        From Table(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('CODIGO_DOC_ITIEM_TRASLADO',Null),
                                                ','))); --Tipo documento traslado de items



  tempcutrasladoitemscerrado cutrasladoitemscerrado%Rowtype;

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

  /*

  select mmitnudo            Numero_del_Documento,
         operating_unit_id   Unidad_Operativa,
         destino_oper_uni_id Provedor_Logistico,
         document_type_id    Tipo_de_Documento
    from ldci_intemmit, ge_items_documento, GE_ITEMS_REQUEST
   where mmitnudo = to_char(GE_ITEMS_REQUEST.id_items_documento)
     and document_type_id = 102 -- Orden de Compra
     and GE_ITEMS_REQUEST.ID_ITEMS_DOCUMENTO =
         ge_items_documento.id_items_documento
     and GE_ITEMS_REQUEST.ITEMS_ID = :NEW.items_id
     and operating_unit_id = :NEW.operating_unit_id
   group by mmitnudo,
            operating_unit_id,
            destino_oper_uni_id,
            document_type_id;
            */
  /* comentariado por accion de mutacion en el trigger
  CURSOR cuTipoBodega
  (
  inuItemId  ge_items.items_id%TYPE,
  inuOrderId or_order.order_id%TYPE
  )
  IS
      SELECT DISTINCT ltt.*
      FROM ge_items i, or_ope_uni_item_bala ouib
         , or_order o, or_order_items oi
         , ldc_tt_tb ltt
      WHERE i.items_id = ouib.items_id
        AND oi.items_id = i.items_id
        AND o.order_id = oi.order_id
        AND ltt.task_type_id = o.task_type_id
        AND ouib.items_id = inuItemId
        AND o.order_id = inuOrderId;
   */

  --cursor para validar si el serial no pertenecen a un cliente
  --200-2470------------
  csbEnt2002470    open.ldc_versionentrega.nombre_entrega%type:='OSS_OYM_DSS_200_2470_4';
  sbAplica2002470  varchar2(1):='N';
  sbMedidorCliente open.ld_parameter.value_chain%type:=nvl(open.dald_parameter.fsbgetvalue_chain('VAL_MEDI_EN_CLIENTES',NULL),'N');
  sbSumaInventario	open.ld_parameter.value_chain%type:=nvl(open.dald_parameter.fsbgetvalue_chain('SUMA_INVEN_MATERIAL_VENDIDO',NULL),'N');
  --200-2470------------
  Cursor cuge_items_seriado(nuitems_id          open.ge_items_seriado.items_id%Type,
                            nuoperating_unit_id open.ge_items_seriado.operating_unit_id%Type,
                            sbserie             open.ge_items_seriado.serie%Type) Is
    Select Count(1) cantidad
      From open.ge_items_seriado g
     Where g.items_id = nuitems_id
       And g.operating_unit_id = nuoperating_unit_id
       And g.serie = sbserie
       And ((g.propiedad <> 'C') or (sbMedidorCliente='S'))--200-2470
       ;


  nucuge_items_seriado Number;

  --curosr para validar si exsite el tipo de trabajo en el parametro

  Cursor cuexiste(nudato      Number,
                  sbparametro open.ld_parameter.value_chain%Type) Is
    Select Count(1) cantidad
      From dual
     Where nudato In
           (Select to_number(column_value)
              From Table(open.ldc_boutilities.splitstrings(sbparametro, ',')));


  nucuexiste Number;


  sbcod_tip_trab_cam_med open.ld_parameter.value_chain%Type := open.dald_parameter.fsbgetvalue_chain('COD_TIP_TRAB_CAM_MED',Null);
  nuiditemsdoc       open.or_uni_item_bala_mov.id_items_documento%Type;
  nuiditemsdocexiste open.or_uni_item_bala_mov.id_items_documento%Type;
  nuiditemsseriado   open.or_uni_item_bala_mov.id_items_seriado%Type;
  sbestadoinv        open.or_uni_item_bala_mov.id_items_estado_inv%Type;
  nuvalorventa       open.or_uni_item_bala_mov.valor_venta%Type;
  nuoperunittarget   open.or_uni_item_bala_mov.target_oper_unit_id%Type;
  nuinitstatus       open.or_uni_item_bala_mov.init_inv_stat_items%Type;

  sbasunto         Varchar2(4000);
  sbmensaje        Varchar2(4000);
  sbatributo0      Varchar2(4000) := 'RETIRAR_UTILITIES';
  sbatributo1      Varchar2(4000) := 'INSTALAR_UTILITIES';
  sbatributo0_0    Varchar2(4000);
  sbatributo1_0    Varchar2(4000);
  nuorderactividad Number;
  nutt             Number;

  ---INICIO CAMBIO 860
  --cursor para saber el documento de pedido realizado a SAP
  Cursor cudocumentopedidoAUTO(inuid_items_documento open.ge_items_documento.id_items_documento%Type) Is
    Select mmitnudo, g2.id_items_documento
      From open.ldci_intemmit, open.ge_items_documento g2
     Where (Select replace(g1.documento_externo,'AUTO_','')
              From open.ge_items_documento g1
             Where g1.id_items_documento = inuid_items_documento
               And document_type_id In
                   (Select to_number(column_value)
                      From Table(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('COD_TIPO_DOC_DES_SAP',
                                                                                                         Null),
                                                                   ',')))) =
           mmitdsap
       And g2.id_items_documento = inuid_items_documento;
  ---FIN CAMBIO 860

Begin
  --200-2470------------------
  IF fblaplicaentrega(csbEnt2002470) Then
     sbAplica2002470 :='S';
  else
    sbAplica2002470:='N';
  end if;
  --200-2470------------------

	If :old.balance = :new.balance And :old.quota = :new.quota And
		:old.total_costs = :new.total_costs And
		:old.occacional_quota = :new.occacional_quota And
		:old.transit_in = :new.transit_in And
		:old.transit_out = :new.transit_out And
		:old.items_id = :new.items_id And
		:old.operating_unit_id = :new.operating_unit_id Then --CA 200-833 se adiciona condicion para que no se dispare el trigger multiples veces.

     ut_trace.trace('No se ejecutará LDCTRGBUDI_OR_OUIB' , 10);

	else
		ut_trace.trace('Inicio LDCTRGBUDI_OR_OUIB', 10);
		-- ARA8732. No realiza actualizaciones sobre la tabla de inventario
		-- si lo que se está modificando Sólo es costo ya que el api
		-- or_boAdjustmentOrder.createorder Sólo está modificando las unidades
		-- del inventario y no modifica el costo, así que toca realizar esta actualización
		-- manualmente en pkOrdenesSinActa.proMueveInventarioUnidOper
		ut_trace.trace(':OLD.balance              ' || :old.balance, 10);
		ut_trace.trace(':NEW.balance              ' || :new.balance, 10);
		ut_trace.trace(':old.quota                ' || :old.quota , 10);
		ut_trace.trace(':NEW.quota                ' || :new.quota , 10);
		ut_trace.trace(':OLD.total_costs          ' || :old.total_costs , 10);
		ut_trace.trace(':new.total_costs          ' || :new.total_costs , 10);
		ut_trace.trace(':old.occacional_quota     ' || :old.occacional_quota, 10);
		ut_trace.trace(':NEW.occacional_quota     ' || :new.occacional_quota, 10);
		ut_trace.trace(':old.transit_in           ' || :old.transit_in , 10);
		ut_trace.trace(':NEW.transit_in           ' || :new.transit_in , 10);
		ut_trace.trace(':old.transit_out          ' || :old.transit_out , 10);
		ut_trace.trace(':NEW.transit_out          ' || :new.transit_out , 10);
		ut_trace.trace(':OLD.items_id             ' || :old.items_id , 10);
		ut_trace.trace(':new.items_id             ' || :new.items_id , 10);
		ut_trace.trace(':OLD.operating_unit_id    ' || :old.operating_unit_id, 10);
		ut_trace.trace(':new.operating_unit_id    ' || :new.operating_unit_id, 10);

		If :old.balance = :new.balance And :old.quota = :new.quota And
			:old.total_costs <> :new.total_costs And
			:old.occacional_quota = :new.occacional_quota And
			:old.transit_in = :new.transit_in And
			:old.transit_out = :new.transit_out And :old.items_id = :new.items_id And
			:old.operating_unit_id = :new.operating_unit_id Then

			sbsolomodificacosto := 'S';
			ut_trace.trace('Sólo se está modificando el costo' , 10);
		Else
			sbsolomodificacosto := 'N';
			ut_trace.trace('sbSoloModificaCosto ' || sbsolomodificacosto, 10 );
			--ELSE
			--VALIDACION 1
			--VERIFICAR SI LA TABLA ACTUALIZA ITEMS DE UN ORDEN LEGALIZADA. LA CUAL DEJO LOS
			--ITEMS EN LA TABLA DE ORDEN X ITEMS
			Begin
				--nuOrderId := 10063476; -- CASO 1 ORDENES
				--nuOrderId := 8804306; -- CASO 2 ORDENES
				--OBTIENE EL VALOR DE LA ORDEN INSTANCIADA. EN CASO DE ERROR
				--SE ESTARIA INSERTADO POR SAP O REALIZANDO UN TRANSLSADO DE ITEM
				--ENTRE BODEGAS YA QUE NO CAPTURO NINGUNA ORDEN
				nuorderid := or_boinstance.fnugetorderidfrominstance();
				ut_trace.trace('nuOrderId ' || nuorderid , 10);
			Exception
				When Others Then
					nuorderid := Null;
					pkerrors.geterrorvar(nuerrcode, sberrmsg);
			End;



			-- ARA8732. Sólo funciona para cuando se está modificando la cantidad
			-- desde AIOSA, o MIOSA.
			If nuorderid Is Null Then
				Begin
					ge_boinstancecontrol.getattributenewvalue('WORK_INSTANCE',
																Null,
																'OR_ORDER',
																'ORDER_ID',
																sborden_id);
					nuorderid := to_number(sborden_id);
				Exception
					When Others Then
						nuorderid := Null;
						pkerrors.geterrorvar(nuerrcode, sberrmsg);
				End;
			End If;

			--VALIDA QUE LA ORDEN EXISTA
			If (daor_order.fblexist(nuorderid)) Then
				ut_trace.trace('La orden ' || nuorderid || ' existe' , 10);
				--Actualización el item cuando es legalizado de una orden por SMARTFLEX
				If updating Then
					ut_trace.trace('UPDATING', 10 );
					--obtener el tipo de trabajo de la orden
					nutt := daor_order.fnugettask_type_id(nuorderid, Null);
					ut_trace.trace('Tipo de trabajo de la orden ' || nuorderid || ': ' || nutt, 10);

					--validar si el tipo de trabajo esta en el paraemtro y es de cambio de medidor
					Open cuexiste(nutt, sbcod_tip_trab_cam_med);
					ut_trace.trace('Abre el cursor CUEXISTE con los parámetros (' || nutt || ',' ||
					sbcod_tip_trab_cam_med || ')', 10);
					Fetch cuexiste
					Into nucuexiste;
					Close cuexiste;
					ut_trace.trace('TIPO DE TRABAJO --> ' || nutt , 10);
					ut_trace.trace('PARAMETRO TIPO DE TRABAJO  --> ' ||
					sbcod_tip_trab_cam_med, 10);
					ut_trace.trace('EXISTE TT EN EL PARAMETRO --> ' || nucuexiste , 10);

					If nucuexiste > 0 Then
						---fin validar tt en paraemtro
						-----validar item
						--OBTENER EL NUMERO DE CUOTAS ESTABLECIDO EN AL LEGALIZACION
						ut_trace.trace('Obtiene el Número de la actividad
										SELECT OOA.ORDER_ACTIVITY_ID
										into nuorderactividad
										FROM OPEN.OR_ORDER_ACTIVITY OOA
										WHERE OOA.Order_Id = ' || nuorderid, 10);
						Begin
							Select max(ooa.order_activity_id)
							Into nuorderactividad
							From open.or_order_activity ooa
							Where ooa.order_id = nuorderid
							  and ooa.task_type_id=nutt;
							--And ooa.status = 'R'
							--And ooa.origin_activity_id Is Null

						Exception
							When Others Then
								pkerrors.geterrorvar(nuerrcode, sberrmsg);
                gi_boerrors.seterrorcodeargument(2741,SQLERRM);
                Raise ex.controlled_error;
						End;

						sbatributo0_0 := or_boinstanceactivities.fsbgetattributevalue(sbatributo0,
																					nuorderactividad);
						ut_trace.trace(' sbatributo0_0 := ' || sbatributo0_0 , 10);
						sbatributo1_0 := or_boinstanceactivities.fsbgetattributevalue(sbatributo1,
																					nuorderactividad);
						ut_trace.trace(' sbatributo1_0 := ' || sbatributo1_0, 10 );
						Open cuge_items_seriado(:new.items_id,
											  :new.operating_unit_id,
											  sbatributo1_0);

						ut_trace.trace('OPEN cuge_items_seriado(' || :new.items_id || ',' ||:new.operating_unit_id || ',' || sbatributo1_0 || ');', 10);
						Fetch cuge_items_seriado
						Into nucuge_items_seriado;
						Close cuge_items_seriado;

						ut_trace.trace('nucuge_items_seriado: ' || nucuge_items_seriado, 10);

						If nucuge_items_seriado > 0 Then
							--/*--ordenes con tipo de trabajo de cambio de medidor
							Begin
								sbmensaje := 'Item [' || :new.items_id ||'] - Unidad de trabajo [' ||:new.operating_unit_id ||'] - RETIRAR_UTILITIES [' || sbatributo0_0 ||'] - INSTALAR_UTILITIES [' || sbatributo1_0 ||'] - Tipo de Trabajo [' || nutt || ']';
								ut_trace.trace(sbmensaje , 10);
								--CUSOR QUE PERMITE VALIDAR SI EL ITEM DEK TIPO DE TRABAJO
								--ASOCIADO A LA ORDEN ES UN ACTIVO O INVENTARIO
								Open cutipobodega(:new.items_id, nuorderid);
								ut_trace.trace('OPEN cuTipoBodega(' || :new.items_id || ', ' ||nuorderid || ')' || ';', 10);
								Fetch cutipobodega
								Into rcldctttb;
								-- CA100-8710: Se una  validación después de abrir el
								-- cursor cuTipoBodega para que en caso de que la variable
								-- rcLdcTtTb.warehouse_type sea nula lance una excepción
								-- que indique que el tipo de trabajo no tiene configurada
								-- la clase de valoración.
								If cutipobodega%Notfound Then
									gi_boerrors.seterrorcodeargument(2741,'El tipo de trabajo ' || nutt ||' no tiene configurada la clase de valoración.');
									Raise ex.controlled_error;
								End If;

								ut_trace.trace('Tipo de item --> ' ||rcldctttb.warehouse_type, 10);
								--VALIDA SI ES ACTIVO
								If (rcldctttb.warehouse_type = csbtiboac) Then
									ut_trace.trace('ACTIVO', 10 );
									Begin

										ut_trace.trace('SELECT balance,total_costs
														INTO   nuSaldoUO,nuSaldoCO
														FROM   ldc_act_ouib
														WHERE  items_id = ' ||:new.items_id || '
														AND    operating_unit_id = ' ||:new.operating_unit_id, 10);

										Select balance, total_costs
										Into nusaldouo, nusaldoco
										From open.ldc_act_ouib
										Where items_id = :new.items_id
										And operating_unit_id = :new.operating_unit_id;

										ut_trace.trace('nuSaldoUO,    ' ||nusaldouo || ',nuSaldoCO     ' ||nusaldoco, 10);
									Exception
										When no_data_found Then
											ut_trace.trace('no data found nuSaldoUO ' ||nusaldouo, 10);
											nusaldouo := 0;
									End;

									ut_trace.trace('SALDO DE ITEMS DE LA UNIDAD OPERATIVA [nuSaldoUO] --> ' ||nusaldouo, 10);
									ut_trace.trace('SALDO DE ITEMS DE LA UNIDAD OPERATIVA :OLD.balance[' ||:old.balance || '] - :NEW.balance[' ||:new.balance || ']', 10);
									ut_trace.trace('INVENTARIO SALDO DE ITEMS FINAL --> ' ||to_char(nusaldouo -(:old.balance - :new.balance)), 10);

									/*  UT_TRACE.TRACE('INVENTARIO COSTO DE ITEMS FINAL --> ' ||
									TO_CHAR(:NEW.balance *
									(:OLD.total_costs /
									:OLD.balance)),
									10);*/

									ut_trace.trace('nuSaldoUO ' || nusaldouo, 10 );

									If (nusaldouo > 0) Then
										--ACCTUALIZA ELBALANCE Y EL COSTO TOTAL. REALIZANDO LAS OPERACIONES
										--RESPECTIVAS PARA EL MOVIMIENTO DE LOS VALORES CORRESPONDIENTES AL ACTIVO
										ut_trace.trace(':OLD.balance - :NEW.balance) <= nuSaldoUO ' ||:old.balance || '-' || :new.balance ||') <= ' || nusaldouo, 10 );
										If ((:old.balance - :new.balance) <= nusaldouo) Then

											-- CA100-8710. Se reescribe la consulta de
											-- acutalización de las unidades de costo
											-- en las tablas activo/inventario para
											-- hacerla más clara y controlar el valor
											-- cero en la división
											/*
											UPDATE ldc_act_ouib
											SET    quota           = :NEW.quota,
											balance          = nuSaldoUO -(:OLD.balance -:NEW.balance),
											total_costs     =(nuSaldoUO -(:OLD.balance - :NEW.balance)) *(:OLD.total_costs / :OLD.balance),
											occacional_quota = :NEW.occacional_quota,
											transit_in       = :NEW.transit_in,
											transit_out      = :NEW.transit_out
											WHERE  items_id = :OLD.items_id
											AND    operating_unit_id =:OLD.operating_unit_id;
											*/

											nucantactinv := nusaldouo -(:old.balance - :new.balance);
											ut_trace.trace('nuCantActInv := nuSaldoUO -(:OLD.balance -:NEW.balance); ' ||nucantactinv || ':= ' || nusaldouo || ' -(' ||:old.balance || ' - ' || :new.balance || ');', 10);

											If :old.balance <> 0 Then
											  nuvaloractinv := (nusaldouo -(:old.balance - :new.balance)) *(:old.total_costs / :old.balance);
											  ut_trace.trace('nuValorActInv := (nuSaldoUO -(:OLD.balance -:NEW.balance)) *(:OLD.total_costs /:OLD.balance); ' ||nuvaloractinv || ':= (' || nusaldouo || ' -(' ||:old.balance || '-' || :new.balance ||')) *(' ||:old.total_costs || '/' ||:old.balance || ');', 10);
											Else
											  nuvaloractinv := nusaldoco - (:old.total_costs -:new.total_costs);
											  ut_trace.trace(' nuValorActInv := nuSaldoCO - (:OLD.TOTAL_COSTS -:NEW.Total_Costs);' ||nuvaloractinv || ':= ' || nusaldoco || ' -(' ||:old.total_costs || ' - ' ||:new.total_costs || ');', 10);
											End If;
											ut_trace.trace('nuValorActInv := ' || nuvaloractinv, 10);

											Update open.ldc_act_ouib
											   Set quota            = :new.quota,
												   balance          = nucantactinv,
												   total_costs      = nuvaloractinv,
												   occacional_quota = :new.occacional_quota,
												   transit_in       = :new.transit_in,
												   transit_out      = :new.transit_out
											 Where items_id = :old.items_id
											   And operating_unit_id = :old.operating_unit_id;

											ut_trace.trace('UPDATE ldc_act_ouib
															SET    quota            = ' ||:new.quota || ',
															balance          = decode (sbSoloModificaCosto, S, balance, nuCantActInv),
															total_costs      = decode (sbSoloModificaCosto, S, nuValorActInv, total_cost),
															occacional_quota = ' ||:new.occacional_quota || ',
															transit_in       = ' ||:new.transit_in || ',
															transit_out      = ' ||:new.transit_out || '
															WHERE  items_id = ' ||:old.items_id || '
															AND    operating_unit_id = ' ||:old.operating_unit_id || ';', 10);

										Else
											--200-2470-----------------------------
											IF sbAplica2002470='S' THEN
												IF :NEW.TOTAL_COSTS!=:OLD.TOTAL_COSTS THEN
													gi_boerrors.seterrorcodeargument(2741,'En la bodega existen ' ||to_char(:old.balance) ||' pero no hay existencias para Activos fijos');
													Raise ex.controlled_error;
												ELSE
													NULL;--NO SE HACE NADA, NO DEBE LANZAR ERROR.
												END IF;
											ELSE
												gi_boerrors.seterrorcodeargument(2741,'En la bodega existen ' ||to_char(:old.balance) ||' pero no hay existencias para Activos fijos');
												Raise ex.controlled_error;
											END IF;
											--200-2470-----------------------------

										End If; --If ((:old.balance - :new.balance) <= nusaldouo) Then

									Else
										--EN CASO QUE NO EXISTE LA CANTIDAD NECESARIA PARA LEGALIZAR LA ORDEN
										--DESPLEGARA UN ERROR MEDIANTE EL TRIGGER.
										If :new.balance > :old.balance Then
											-- CA100-8710. Se reescribe la consulta de
											-- acutalización de las unidades de costo
											-- en las tablas activo/inventario para
											-- hacerla más clara y controlar el valor
											-- cero en la división
											/*   UPDATE ldc_act_oui
											SET    quota   = :NEW.quota,
												balance = nuSaldoUO -
												(:OLD.balance -
												:NEW.balance),
												total_costs =(nuSaldoUO -
												(:OLD.balance - :NEW.balance)) *
												(:OLD.total_costs / :OLD.balance),
												occacional_quota = :NEW.occacional_quota,
												transit_in       = :NEW.transit_in,
												transit_out      = :NEW.transit_out
												WHERE  items_id = :OLD.items_id
												AND    operating_unit_id =:OLD.operating_unit_id;*/
											nucantactinv := nusaldouo -(:old.balance - :new.balance);
											ut_trace.trace(' nuCantActInv := nuSaldoUO -(:OLD.balance -:NEW.balance); ' ||nucantactinv || ':= ' || nusaldouo || ' -(' ||:old.balance || ' - ' || :new.balance || ');', 10);
											If :old.balance <> 0 Then
												nuvaloractinv := (nusaldouo -(:old.balance - :new.balance)) *(:old.total_costs / :old.balance);
												ut_trace.trace(' nuValorActInv := (nuSaldoUO -(:OLD.balance -:NEW.balance)) *(:OLD.total_costs /:OLD.balance);' ||nuvaloractinv || ':= (' || nusaldouo || ' -(' ||:old.balance || ' - ' ||:new.balance ||')) *(' ||:old.total_costs || '/ ' ||:old.balance || ');', 10);
											Else
												nuvaloractinv := nusaldoco - (:old.total_costs -:new.total_costs);
												ut_trace.trace('  nuValorActInv := nuSaldoCO -(:OLD.TOTAL_COSTS -:NEW.Total_Costs);' ||nuvaloractinv || ':=' || nusaldoco || ' -(' ||:old.total_costs || ' - ' ||:new.total_costs || ');', 10);
											End If;
											ut_trace.trace('nuValorActInv := ' || nuvaloractinv, 10);

											Update open.ldc_act_ouib
												Set quota            = :new.quota,
												balance          = nucantactinv, /*decode(sbSoloModificaCosto,'S',balance,nuCantActInv),*/
												total_costs      = nuvaloractinv, /*decode(sbSoloModificaCosto,'S',nuValorActInv,total_costs),*/
												occacional_quota = :new.occacional_quota,
												transit_in       = :new.transit_in,
												transit_out      = :new.transit_out
												Where items_id = :old.items_id
												And operating_unit_id = :old.operating_unit_id;

											ut_trace.trace('UPDATE ldc_act_ouib
												SET    quota = ' ||:new.quota || ',
												balance = decode (sbSoloModificaCosto, S, balance, nuCantActInv),
												total_costs      = decode (sbSoloModificaCosto, S, nuValorActInv, total_cost),
												occacional_quota = ' ||:new.occacional_quota || ',
												transit_in       = ' ||:new.transit_in || ',
												transit_out      = ' ||:new.transit_out || '
												WHERE  items_id = ' ||:old.items_id || '
												AND    operating_unit_id = ' ||:old.operating_unit_id || ';', 10);
										Else
											--200-2470-----------------------------
											IF sbAplica2002470='S' THEN
												IF :NEW.TOTAL_COSTS!=:OLD.TOTAL_COSTS THEN
													gi_boerrors.seterrorcodeargument(2741,'No hay existencias para retirar Activos fijos del tipo de trabajo [' ||rcldctttb.task_type_id || ']');
													Raise ex.controlled_error;
												ELSE
													NULL;---NO DEBE HACER NADA
												END IF;
											ELSE
												gi_boerrors.seterrorcodeargument(2741,'No hay existencias para retirar Activos fijos del tipo de trabajo [' ||rcldctttb.task_type_id || ']');
												Raise ex.controlled_error;
											END IF;
											--200-2470-----------------------------
										End If; --If :new.balance > :old.balance Then
										--Raise ex.controlled_error; --200-2470----------------------------- se coloca dentro del if
									End If; --If (nusaldouo > 0) Then SI SALDO ACTIVO > 0
								End If; --If (rcldctttb.warehouse_type = csbtiboac) Then SI ES ACTIVO

								--VALIDA SI ES Inventarios
								If (rcldctttb.warehouse_type = csbtiboin) Then
									ut_trace.trace('INVENTARIO' , 10);

									ut_trace.trace('SELECT balance,total_costs
													INTO   nuSaldoUO,nuSaldoCO
													FROM   ldc_inv_ouib
													WHERE  items_id = ' ||
													:new.items_id || '
													AND    operating_unit_id =' ||
													:new.operating_unit_id, 10);

									Begin
										Select balance, total_costs
										Into nusaldouo, nusaldoco
										From open.ldc_inv_ouib
										Where items_id = :new.items_id
										And operating_unit_id = :new.operating_unit_id;
									Exception
										When no_data_found Then
											nusaldouo := 0;
									End;

									ut_trace.trace('SALDO DE ITEMS DE LA UNIDAD OPERATIVA [nuSaldoUO] --> ' ||nusaldouo, 10);
									ut_trace.trace('SALDO DE ITEMS DE LA UNIDAD OPERATIVA :OLD.balance[' ||:old.balance || '] - :NEW.balance[' ||:new.balance || ']', 10);
									ut_trace.trace('INVENTARIO SALDO DE ITEMS FINAL --> ' ||
												   to_char(nusaldouo -(:old.balance - :new.balance)), 10);
									ut_trace.trace('INVENTARIO COSTO DE ITEMS FINAL --> ' ||to_char(:new.balance *(:old.total_costs / :old.balance)), 10);
									ut_trace.trace('IF (' || nusaldouo || ' > 0) THEN' , 10);

									If (nusaldouo > 0) Then
										ut_trace.trace('IF ((' || :old.balance || ' - ' ||:new.balance || ') <= ' || nusaldouo ||') THEN', 10);
										If ((:old.balance - :new.balance) <= nusaldouo) Then
											--ACCTUALIZA EL BALANCE Y EL COSTO TOTAL. REALIZANDO LAS OPERACIONES
											--RESPECTIVAS PARA EL MOVIMIENTO DE LOS VALORES CORRESPONDIENTES AL INVENTARIO
											-- CA100-8710. Se reescribe la consulta de
											-- acutalización de las unidades de costo
											-- en las tablas activo/inventario para
											-- hacerla más clara y controlar el valor
											-- cero en la división

											/* UPDATE ldc_inv_ouib
												SET    quota            = :NEW.quota,
												balance          = nuSaldoUO -
												(:OLD.balance -
												:NEW.balance),
												total_costs     =
												(nuSaldoUO -
												(:OLD.balance - :NEW.balance)) *
												(:OLD.total_costs / :OLD.balance),
												occacional_quota = :NEW.occacional_quota,
												transit_in       = :NEW.transit_in,
												transit_out      = :NEW.transit_out
												WHERE  items_id = :OLD.items_id
												AND    operating_unit_id =
												:OLD.operating_unit_id;*/

											nucantactinv := nusaldouo -(:old.balance - :new.balance);
											ut_trace.trace(' nuCantActInv := nuSaldoUO - (:OLD.balance - :NEW.balance); ' ||nucantactinv || ':= ' || nusaldouo ||' - (' || :old.balance || ' - ' ||:new.balance, 10);

											If :old.balance <> 0 Then
												nuvaloractinv := (nusaldouo -(:old.balance - :new.balance)) *(:old.total_costs / :old.balance);
											Else
												nuvaloractinv := nusaldoco - (:old.total_costs -:new.total_costs);
											End If;

											ut_trace.trace('nuValorActInv ' || nuvaloractinv , 10);

											Update open.ldc_inv_ouib
												Set quota            = :new.quota,
												balance          = nucantactinv,
												total_costs      = nuvaloractinv,
												occacional_quota = :new.occacional_quota,
												transit_in       = :new.transit_in,
												transit_out      = :new.transit_out
											Where items_id = :old.items_id
												And operating_unit_id = :old.operating_unit_id;

											ut_trace.trace('UPDATE ldc_inv_ouib
																SET    quota            = ' ||:new.quota || ',
																balance          = decode (sbSoloModificaCosto, S, balance, nuCantActInv),
																total_costs      = decode (sbSoloModificaCosto, S, nuValorActInv, total_cost),
																occacional_quota = ' ||:new.occacional_quota || ',
																transit_in       = ' ||:new.transit_in || ',
																transit_out      = ' ||:new.transit_out || '
																WHERE  items_id = ' ||:old.items_id || '
																AND    operating_unit_id = ' ||:old.operating_unit_id || ';', 10);
										Else
										--200-2470-----------------------------
											IF sbAplica2002470='S' THEN
												IF :NEW.TOTAL_COSTS!=:OLD.TOTAL_COSTS THEN
													gi_boerrors.seterrorcodeargument(2741,'En la bodega existen ' ||to_char(:old.balance) ||' pero no hay existencias para Inventarios');
													Raise ex.controlled_error;
												ELSE
													NULL; --NO DEBE HACER NADA
												END IF;
											ELSE
												gi_boerrors.seterrorcodeargument(2741,'En la bodega existen ' ||to_char(:old.balance) ||' pero no hay existencias para Inventarios');
												Raise ex.controlled_error;
											END IF;
										--200-2470-----------------------------
										End If; --If ((:old.balance - :new.balance) <= nusaldouo) Then

									Else
										--EN CASO QUE NO EXISTE LA CANTIDAD NECESARIA PARA LEGALIZAR LA ORDEN
										--DESPLEGARA UN ERROR MEDIANTE EL TRIGGER.
										If :new.balance > :old.balance Then
											--ACCTUALIZA EL BALANCE Y EL COSTO TOTAL. REALIZANDO LAS OPERACIONES
											--RESPECTIVAS PARA EL MOVIMIENTO DE LOS VALORES CORRESPONDIENTES AL INVENTARIO
											-- CA100-8710. Se reescribe la consulta de
											-- acutalización de las unidades de costo
											-- en las tablas activo/inventario para
											-- hacerla más clara y controlar el valor
											-- cero en la división
											/*   UPDATE ldc_inv_ouib
											SET    quota            = :NEW.quota,
											balance          = nuSaldoUO -
											(:OLD.balance -
											:NEW.balance),
											total_costs     =
											(nuSaldoUO -
											(:OLD.balance - :NEW.balance)) *
											(:OLD.total_costs / :OLD.balance),
											occacional_quota = :NEW.occacional_quota,
											transit_in       = :NEW.transit_in,
											transit_out      = :NEW.transit_out
											WHERE  items_id = :OLD.items_id
											AND    operating_unit_id =
											:OLD.operating_unit_id;*/

											nucantactinv := nusaldouo -(:old.balance - :new.balance);
											If :old.balance <> 0 Then
												nuvaloractinv := (nusaldouo - (:old.balance - :new.balance)) * (:old.total_costs / :old.balance);
											Else
												nuvaloractinv := nusaldoco - (:old.total_costs -:new.total_costs);
											End If;
											ut_trace.trace('nuValorActInv ' || nuvaloractinv , 10);

											Update open.ldc_inv_ouib
											   Set quota            = :new.quota,
												   balance          = nucantactinv,
												   total_costs      = nuvaloractinv,
												   occacional_quota = :new.occacional_quota,
												   transit_in       = :new.transit_in,
												   transit_out      = :new.transit_out
											 Where items_id = :old.items_id
											   And operating_unit_id = :old.operating_unit_id;

											ut_trace.trace('UPDATE ldc_inv_ouib
																SET    quota            = ' ||:new.quota || ',
																	   balance          = decode (sbSoloModificaCosto, S, balance, nuCantActInv),
																	   total_costs      = decode (sbSoloModificaCosto, S, nuValorActInv, total_cost),
																	   occacional_quota = ' ||:new.occacional_quota || ',
																	   transit_in       = ' ||:new.transit_in || ',
																	   transit_out      = ' ||:new.transit_out || '
																WHERE  items_id = ' ||:old.items_id || '
																AND    operating_unit_id = ' ||:old.operating_unit_id || ';', 10);



										Else
											--200-2470-----------------------------
											IF sbAplica2002470='S' THEN
												IF :NEW.TOTAL_COSTS!=:OLD.TOTAL_COSTS THEN
													gi_boerrors.seterrorcodeargument(2741,'No hay existencias para retirar Inventario del tipo de trabajo [' ||rcldctttb.task_type_id || ']');
													Raise ex.controlled_error;
												ELSE
													NULL; --NO DEBE HACER NADA
												END IF;
											ELSE
												gi_boerrors.seterrorcodeargument(2741,'No hay existencias para retirar Inventario del tipo de trabajo [' ||rcldctttb.task_type_id || ']');
												Raise ex.controlled_error;
											END IF;
											--200-2470-----------------------------
										End If;--If :new.balance > :old.balance Then
									End If; --If (nusaldouo > 0) Then
								End If; --If (rcldctttb.warehouse_type = csbtiboin) Then
								--COMMIT;
								Close cutipobodega;
							Exception
								When ex.controlled_error Then
									Raise;
								When no_data_found Then
									If (cutipobodega%Isopen) Then
										Close cutipobodega;
									End If;
									nuregafect := 0;
									gi_boerrors.seterrorcodeargument(2741,'No se encontró registro para la bodega.');
									Raise;
								When Others Then
									If (cutipobodega%Isopen) Then
										Close cutipobodega;
									End If;
									nuregafect := 0;
									gi_boerrors.seterrorcodeargument(2741,'Se presentó un error actualizando en bodega.');
									Raise;
							End;
						--*/
						End If; --If nucuge_items_seriado > 0 Then
						-----------------------
					Else
						--/*--ordenes con tipo de trabajo diferente a cambio de medidor
						ut_trace.trace('ordenes con tipo de trabajo diferente a cambio de medidor', 10);
						Begin
							--CUSOR QUE PERMITE VALIDAR SI EL ITEM DEK TIPO DE TRABAJO
							--ASOCIADO A LA ORDEN ES UN ACTIVO O INVENTARIO
							ut_trace.trace('OPEN cuTipoBodega(' || :new.items_id || ', ' ||
							nuorderid || ');', 10);
							Open cutipobodega(:new.items_id, nuorderid);
							Fetch cutipobodega
							Into rcldctttb;
							-- CA100-8710: Se una  validación después de abrir el
							-- cursor cuTipoBodega para que en caso de que la variable
							-- rcLdcTtTb.warehouse_type sea nula lance una excepción
							-- que indique que el tipo de trabajo no tiene configurada
							-- la clase de valoración.
							If cutipobodega%Notfound Then
								gi_boerrors.seterrorcodeargument(2741,'El tipo de trabajo ' || nutt ||' no tiene configurada la clase de valoración.');
								Raise ex.controlled_error;
							End If;

							ut_trace.trace('Tipo de item --> ' ||rcldctttb.warehouse_type, 10);
							--VALIDA SI ES ACTIVO
							If (rcldctttb.warehouse_type = csbtiboac) Then
								ut_trace.trace('es activo' , 10);
								Begin
									ut_trace.trace('SELECT balance,total_costs
													INTO nuSaldoUO,nuSaldoCO
													FROM   ldc_act_ouib
													WHERE  items_id = ' ||:new.items_id || '
													AND    operating_unit_id = ' ||:new.operating_unit_id, 10);

									Select balance, total_costs
									Into nusaldouo, nusaldoco
									From open.ldc_act_ouib
									Where items_id = :new.items_id
									And operating_unit_id = :new.operating_unit_id;
								Exception
									When no_data_found Then
										nusaldouo := 0;
								End;

								/*ut_trace.trace('SALDO DE ITEMS DE LA UNIDAD OPERATIVA [nuSaldoUO] --> ' ||nuSaldoUO);
								ut_trace.trace('SALDO DE ITEMS DE LA UNIDAD OPERATIVA :OLD.balance[' ||:OLD.balance ||'] - :NEW.balance[' ||:NEW.balance || ']');
								ut_trace.trace('INVENTARIO SALDO DE ITEMS FINAL --> ' ||TO_CHAR(nuSaldoUO - (:OLD.balance -:NEW.balance)));
								ut_trace.trace('INVENTARIO COSTO DE ITEMS FINAL --> ' ||TO_CHAR(:NEW.balance *(:OLD.total_costs /:OLD.balance)));*/

								If (nusaldouo > 0) Then
									ut_trace.trace('nuSaldoUO ' || nusaldouo , 10);
									--ACCTUALIZA ELBALANCE Y EL COSTO TOTAL. REALIZANDO LAS OPERACIONES
									--RESPECTIVAS PARA EL MOVIMIENTO DE LOS VALORES CORRESPONDIENTES AL ACTIVO
									If ((:old.balance - :new.balance) <= nusaldouo) Then
										ut_trace.trace('IF ((:OLD.balance - :NEW.balance) <= nuSaldoUO) THEN ' ||
										:old.balance || '- ' || :new.balance ||
										') <= ' || nusaldouo, 10);
										-- CA100-8710. Se reescribe la consulta de
										-- acutalización de las unidades de costo
										-- en las tablas activo/inventario para
										-- hacerla más clara y controlar el valor
										-- cero en la división

										nucantactinv := nusaldouo -(:old.balance - :new.balance);
										ut_trace.trace('nuCantActInv := nuSaldoUO -(:OLD.balance -:NEW.balance); ' ||nucantactinv || ':= ' || nusaldouo || ' -(' ||:old.balance || ' - ' || :new.balance || ');', 10);
										If :old.balance <> 0 Then
											nuvaloractinv := (nusaldouo -(:old.balance - :new.balance)) *(:old.total_costs / :old.balance);
											ut_trace.trace(' nuValorActInv := (nuSaldoUO -(:OLD.balance -:NEW.balance)) *(:OLD.total_costs /:OLD.balance); ' ||nuvaloractinv || ':= (' || nusaldouo || '-(' ||:old.balance || ' - ' || :new.balance ||')) *(' ||:old.total_costs || '/' ||:old.balance || ');', 10);
										Else
											nuvaloractinv := nusaldoco -(:old.total_costs - :new.total_costs);
											ut_trace.trace('nuValorActInv := nuSaldoCO -(:OLD.TOTAL_COSTS -:NEW.Total_Costs);' ||nuvaloractinv || ':= ' || nusaldoco || '-(' ||:old.total_costs || '- ' ||:new.total_costs || ');', 10);
										End If;

										Update open.ldc_act_ouib
											Set quota            = :new.quota,
											balance          = nucantactinv,
											total_costs      = nuvaloractinv,
											occacional_quota = :new.occacional_quota,
											transit_in       = :new.transit_in,
											transit_out      = :new.transit_out
										Where items_id = :old.items_id
											And operating_unit_id = :old.operating_unit_id;

										ut_trace.trace('UPDATE ldc_act_ouib
															SET    quota            = ' ||:new.quota || ',
															balance          = decode (sbSoloModificaCosto, S, balance, nuCantActInv),
															total_costs      = decode (sbSoloModificaCosto, S, nuValorActInv, total_cost),
															occacional_quota = ' ||:new.occacional_quota || ',
															transit_in       = ' ||:new.transit_in || ',
															transit_out      = ' ||:new.transit_out || '
															WHERE  items_id = ' ||:old.items_id || '
															AND    operating_unit_id = ' ||:old.operating_unit_id || ';', 10);

										/* UPDATE ldc_act_ouib
										SET    quota            = :NEW.quota,
										balance          = nuSaldoUO -
										(:OLD.balance -
										:NEW.balance),
										total_costs     =
										(nuSaldoUO -
										(:OLD.balance - :NEW.balance)) *
										(:OLD.total_costs / :OLD.balance),
										occacional_quota = :NEW.occacional_quota,
										transit_in       = :NEW.transit_in,
										transit_out      = :NEW.transit_out
										WHERE  items_id = :OLD.items_id
										AND    operating_unit_id =
										:OLD.operating_unit_id;*/
									Else
										--200-2470-----------------------------
										IF sbAplica2002470='S' THEN
											IF :NEW.TOTAL_COSTS!=:OLD.TOTAL_COSTS THEN
												gi_boerrors.seterrorcodeargument(2741,'En la bodega existen ' ||to_char(:old.balance) ||' pero no hay existencias para Activos fijos');
												Raise ex.controlled_error;
											ELSE
												NULL; --NO DEBE HACER NADA
											END IF;
										ELSE
											gi_boerrors.seterrorcodeargument(2741,'En la bodega existen ' ||to_char(:old.balance) ||' pero no hay existencias para Activos fijos');
											Raise ex.controlled_error;
										END IF;
										--200-2470-----------------------------
									End If;
								Else
									--EN CASO QUE NO EXISTE LA CANTIDAD NECESARIA PARA LEGALIZAR LA ORDEN
									--DESPLEGARA UN ERROR MEDIANTE EL TRIGGER.
									--DESPLEGARA UN ERROR MEDIANTE EL TRIGGER.
									If :new.balance > :old.balance Then
										-- CA100-8710. Se reescribe la consulta de
										-- acutalización de las unidades de costo
										-- en las tablas activo/inventario para
										-- hacerla más clara y controlar el valor
										-- cero en la división
										nucantactinv := nusaldouo -(:old.balance - :new.balance);
										If :old.balance <> 0 Then
											nuvaloractinv := (nusaldouo -(:old.balance - :new.balance)) *(:old.total_costs / :old.balance);
										Else
											nuvaloractinv := nusaldoco -(:old.total_costs - :new.total_costs);
										End If;

										Update open.ldc_act_ouib
											Set quota        = :new.quota,
											balance          = nucantactinv,
											total_costs      = nuvaloractinv,
											occacional_quota = :new.occacional_quota,
											transit_in       = :new.transit_in,
											transit_out      = :new.transit_out
										Where items_id = :old.items_id
											And operating_unit_id = :old.operating_unit_id;

										ut_trace.trace('UPDATE ldc_act_ouib
														SET    quota            = ' ||:new.quota || ',
														balance          = decode (sbSoloModificaCosto, S, balance, nuCantActInv),
														total_costs      = decode (sbSoloModificaCosto, S, nuValorActInv, total_cost),
														occacional_quota = ' ||:new.occacional_quota || ',
														transit_in       = ' ||:new.transit_in || ',
														transit_out      = ' ||:new.transit_out || '
														WHERE  items_id = ' ||:old.items_id || '
														AND    operating_unit_id = ' ||:old.operating_unit_id || ';', 10);

										/*UPDATE ldc_act_ouib
										SET    quota       = :NEW.quota,
										balance     = nuSaldoUO -
										(:OLD.balance -
										:NEW.balance),
										total_costs =
										(nuSaldoUO -
										(:OLD.balance - :NEW.balance)) *
										(:OLD.total_costs / :OLD.balance),
										occacional_quota = :NEW.occacional_quota,
										transit_in       = :NEW.transit_in,
										transit_out      = :NEW.transit_out
										WHERE  items_id = :OLD.items_id
										AND    operating_unit_id =
										:OLD.operating_unit_id;*/
									Else
										--200-2470-----------------------------
										IF sbAplica2002470='S' THEN
											IF :NEW.TOTAL_COSTS!=:OLD.TOTAL_COSTS THEN
												gi_boerrors.seterrorcodeargument(2741,'No hay existencias para retirar Activos fijos del tipo de trabajo [' ||rcldctttb.task_type_id || ']');
												Raise ex.controlled_error;
											ELSE
												NULL; --NO DEBE HACER NADA
											END IF;
										ELSE
											gi_boerrors.seterrorcodeargument(2741,'No hay existencias para retirar Activos fijos del tipo de trabajo [' ||rcldctttb.task_type_id || ']');
											Raise ex.controlled_error;
										END IF;
										--200-2470-----------------------------
									End If;--If :new.balance > :old.balance Then
								End If;--If (nusaldouo > 0) Then
							End If;--If (rcldctttb.warehouse_type = csbtiboac) Then

							--VALIDA SI ES Inventarios
							If (rcldctttb.warehouse_type = csbtiboin) Then
								ut_trace.trace('es inventario' , 10);
								ut_trace.trace('SELECT balance,
												total_costs
												INTO   nuSaldoUO,
												nuSaldoCO
												FROM   ldc_inv_ouib
												WHERE  items_id = ' ||
												:new.items_id || '
												AND    operating_unit_id = ' ||
												:new.operating_unit_id, 10);
								Begin
									Select balance, total_costs
									Into nusaldouo, nusaldoco
									From open.ldc_inv_ouib
									Where items_id = :new.items_id
									And operating_unit_id = :new.operating_unit_id;
								Exception
									When no_data_found Then
										nusaldouo := 0;
								End;

								/*
								ut_trace.trace('SALDO DE ITEMS DE LA UNIDAD OPERATIVA [nuSaldoUO] --> ' ||nuSaldoUO);
								ut_trace.trace('SALDO DE ITEMS DE LA UNIDAD OPERATIVA :OLD.balance[' ||:OLD.balance ||'] - :NEW.balance[' ||:NEW.balance || ']');
								ut_trace.trace('INVENTARIO SALDO DE ITEMS FINAL --> ' ||TO_CHAR(nuSaldoUO - (:OLD.balance -:NEW.balance)));
								ut_trace.trace('INVENTARIO COSTO DE ITEMS FINAL --> ' ||TO_CHAR(:NEW.balance *(:OLD.total_costs /:OLD.balance)));*/
								ut_trace.trace('nuSaldoUO ' || nusaldouo , 10);
								If (nusaldouo > 0) Then
									ut_trace.trace(' IF ((:OLD.balance - :NEW.balance) <= nuSaldoUO) THEN ' ||:old.balance || '-' || :new.balance ||') <= ' || nusaldouo, 10);
									If ((:old.balance - :new.balance) <= nusaldouo) Then
										--ACCTUALIZA EL BALANCE Y EL COSTO TOTAL. REALIZANDO LAS OPERACIONES
										--RESPECTIVAS PARA EL MOVIMIENTO DE LOS VALORES CORRESPONDIENTES AL INVENTARIO
										-- CA100-8710. Se reescribe la consulta de
										-- acutalización de las unidades de costo
										-- en las tablas activo/inventario para
										-- hacerla más clara y controlar el valor
										-- cero en la división
										nucantactinv := nusaldouo -(:old.balance - :new.balance);
										If :old.balance <> 0 Then
											nuvaloractinv := (nusaldouo -(:old.balance - :new.balance)) *(:old.total_costs / :old.balance);
											ut_trace.trace(' nuValorActInv := (nuSaldoUO - (:OLD.balance - :NEW.balance)) *(:OLD.total_costs / :OLD.balance);  ' ||nuvaloractinv || ':= (' || nusaldouo ||' - (' || :old.balance || ' - ' ||:new.balance ||')) *(' ||:old.total_costs || ' / ' ||:old.balance || ')', 10);
										Else
											nuvaloractinv := nusaldoco -(:old.total_costs - :new.total_costs);
											ut_trace.trace(' nuValorActInv := nuSaldoCO -(:OLD.TOTAL_COSTS - :NEW.Total_Costs); ' ||nuvaloractinv || ':= ' || nusaldoco || ' -(' ||:old.total_costs || ' - ' ||:new.total_costs || ');  ', 10);
										End If;
										ut_trace.trace('nuValorActInv ' || nuvaloractinv , 10);

										Update open.ldc_inv_ouib
											Set quota            = :new.quota,
											balance          = nucantactinv,
											total_costs      = nuvaloractinv,
											occacional_quota = :new.occacional_quota,
											transit_in       = :new.transit_in,
											transit_out      = :new.transit_out
										Where items_id = :old.items_id
											And operating_unit_id = :old.operating_unit_id;


										ut_trace.trace('  UPDATE ldc_inv_ouib
														SET    quota            = ' ||:new.quota || ',
															  balance          = decode (sbSoloModificaCosto, S, balance, nuCantActInv),
															   total_costs      = decode (sbSoloModificaCosto, S, nuValorActInv, total_cost),
															   occacional_quota = ' ||:new.occacional_quota || ',
															   transit_in       = ' ||:new.transit_in || ',
															   transit_out      = ' ||:new.transit_out || '
														WHERE  items_id = ' ||:old.items_id || '
														AND    operating_unit_id = ' ||:old.operating_unit_id || ';', 10);



										/* UPDATE ldc_inv_ouib
										SET    quota            = :NEW.quota,
										balance          = nuSaldoUO -
										(:OLD.balance -
										:NEW.balance),
										total_costs     =
										(nuSaldoUO -
										(:OLD.balance - :NEW.balance)) *
										(:OLD.total_costs / :OLD.balance),
										occacional_quota = :NEW.occacional_quota,
										transit_in       = :NEW.transit_in,
										transit_out      = :NEW.transit_out
										WHERE  items_id = :OLD.items_id
										AND    operating_unit_id =
										:OLD.operating_unit_id;*/
									Else
										--200-2470-----------------------------
										IF sbAplica2002470='S' THEN
											IF :NEW.TOTAL_COSTS!=:OLD.TOTAL_COSTS THEN
												gi_boerrors.seterrorcodeargument(2741,'En la bodega existen ' ||to_char(:old.balance) ||' pero no hay existencias para Inventarios');
												Raise ex.controlled_error;
											ELSE
												NULL; --NO DEBE HACER NADA
											END IF;
										ELSE
											gi_boerrors.seterrorcodeargument(2741,'En la bodega existen ' ||to_char(:old.balance) ||' pero no hay existencias para Inventarios');
											Raise ex.controlled_error;
										END IF;
										--200-2470-----------------------------
									End If;--If ((:old.balance - :new.balance) <= nusaldouo) Then
								Else
									--EN CASO QUE NO EXISTE LA CANTIDAD NECESARIA PARA LEGALIZAR LA ORDEN
									--DESPLEGARA UN ERROR MEDIANTE EL TRIGGER.
									If :new.balance > :old.balance Then
										-- CA100-8710. Se reescribe la consulta de
										-- acutalización de las unidades de costo
										-- en las tablas activo/inventario para
										-- hacerla más clara y controlar el valor
										-- cero en la división
										nucantactinv := nusaldouo -(:old.balance - :new.balance);
										If :old.balance <> 0 Then
											nuvaloractinv := (nusaldouo -(:old.balance - :new.balance)) *(:old.total_costs / :old.balance);
										Else
											nuvaloractinv := nusaldoco -(:old.total_costs - :new.total_costs);
										End If;
										ut_trace.trace('nuValorActInv ' || nuvaloractinv , 10);

										Update open.ldc_inv_ouib
											Set quota            = :new.quota,
											balance          = nucantactinv,
											total_costs      = nuvaloractinv,
											occacional_quota = :new.occacional_quota,
											transit_in       = :new.transit_in,
											transit_out      = :new.transit_out
										Where items_id = :old.items_id
											And operating_unit_id = :old.operating_unit_id;

										ut_trace.trace('  UPDATE ldc_inv_ouib
														SET    quota            = ' ||:new.quota || ',
															   balance          = decode (sbSoloModificaCosto, S, balance, nuCantActInv),
															   total_costs      = decode (sbSoloModificaCosto, S, nuValorActInv, total_cost),
															   occacional_quota = ' ||:new.occacional_quota || ',
															   transit_in       = ' ||:new.transit_in || ',
															   transit_out      = ' ||:new.transit_out || '
														WHERE  items_id = ' ||:old.items_id || '
														AND    operating_unit_id = ' ||:old.operating_unit_id || ';', 10);

										/* UPDATE ldc_inv_ouib
										SET    quota       = :NEW.quota,
											 balance     = nuSaldoUO -
														   (:OLD.balance -
														   :NEW.balance),
											 total_costs =
											 (nuSaldoUO -
											 (:OLD.balance - :NEW.balance)) *
											 (:OLD.total_costs / :OLD.balance),
											 occacional_quota = :NEW.occacional_quota,
											 transit_in       = :NEW.transit_in,
											 transit_out      = :NEW.transit_out
										WHERE  items_id = :OLD.items_id
										AND    operating_unit_id =
											 :OLD.operating_unit_id;*/
									Else
										--200-2470-----------------------------
										IF sbAplica2002470='S' THEN
											IF :NEW.TOTAL_COSTS!=:OLD.TOTAL_COSTS THEN
												gi_boerrors.seterrorcodeargument(2741,'No hay existencias para retirar Inventario del tipo de trabajo [' ||rcldctttb.task_type_id || ']');
												Raise ex.controlled_error;
											ELSE
												NULL; --NO DEBE HACER NADA
											END IF;
										ELSE
											gi_boerrors.seterrorcodeargument(2741,'No hay existencias para retirar Inventario del tipo de trabajo [' ||rcldctttb.task_type_id || ']');
											Raise ex.controlled_error;
										END IF;
										--200-2470-----------------------------
									End If; --If :new.balance > :old.balance Then
								End If;--If (nusaldouo > 0) Then
							End If;--If (rcldctttb.warehouse_type = csbtiboin) Then

							--COMMIT;
							Close cutipobodega;
						Exception
							When ex.controlled_error Then
								Raise;
							When no_data_found Then
								If (cutipobodega%Isopen) Then
									Close cutipobodega;
								End If;
								nuregafect := 0;
								gi_boerrors.seterrorcodeargument(2741,
								'No se encontró registro para la bodega.');
								Raise;
							When Others Then
								If (cutipobodega%Isopen) Then
									Close cutipobodega;
								End If;
								nuregafect := 0;
								gi_boerrors.seterrorcodeargument(2741,
								'Se presentó un error actualizando en bodega.');
								Raise;
						End;
						--*/
					End If;--If nucuexiste > 0 Then
				End If;--If updating Then
			Elsif inserting Then
				ut_trace.trace('insertando', 10 );
				------INSERT INTO LDC_MENSAJES (mensaje,fecha) VALUES  ('OR_OPE_UNI_ITEM_BALA INSERTING control 1',SYSDATE);
				--VALIDACION 2
				--VERIFICAR SI LA TABLA INSERTA ITEMS DE UN ORDEN LEGALIZADA. LA CUAL INDICA QUE
				--PROVIENE DE SAP
				--INSERT INTO LDC_MENSAJES VALUES ('INSERTING SAP', SYSDATE);
				--/*--Inserción de compra materiales SAP. ya que SAP inserta en la entidad sin legalizar
				--una orden ya que relaiza esto mediante la relacion de un documneto
				Begin
					--OBTINE EL ULTIMO DOCUMENTO CON LA FECHA DE DESPACHO MAS RECIENTE. INDICANDO
					--QUE LA SOLICITUD DE ITEMS FUE CARGADA Y SE INSERTARAN NUEVOS ITEMS PARA
					--ACTIVO O INVENTARIO. ESTO MEDIANTE EL PROVEEDOR LOGISTICO EL CUAL SE OBTIENE
					--EN ESTE CURSOR PARA SER VALIDADO Y DETERMINAR SI EL ITEM ES DEINVENTARIO O ACTIVO
					/*INSERT INTO LDC_MENSAJES
					VALUES
					  (':NEW.OPERATING_UNIT_ID [' || :NEW.OPERATING_UNIT_ID || '] - :NEW.ITEMS_ID [' || :NEW.ITEMS_ID || ']',SYSDATE);*/
					ut_trace.trace('or_boItemsMove.getTempValues(' ||nuiditemsdoc || ',' ||
																	 nuiditemsseriado || ',' ||
																	 sbestadoinv || ',' ||
																	 nuvalorventa || ',' ||
																	 nuoperunittarget || ',' ||nuinitstatus, 10);
					or_boitemsmove.gettempvalues(nuiditemsdoc,
												 nuiditemsseriado,
												 sbestadoinv,
												 nuvalorventa,
												 nuoperunittarget,
												 nuinitstatus);
					--Obtiene el documento de la instancia
					ut_trace.trace('nuIdItemsDoc ' || nuiditemsdoc, 10 );
					nuiditemsdoc := nvl(nuiditemsdoc, 0);

          --INICIO CAMBIO 860
          IF FBLAPLICAENTREGAXCASO('0000860') THEN

            Open cudocumentopedidoAUTO (nuiditemsdoc);
            ut_trace.trace('OPEN cudocumentopedidoAUTO(nuIdItemsDoc);  nuIdItemsDoc=' ||nuiditemsdoc, 10);
            Fetch cudocumentopedidoAUTO Into tempcudocumentopedido;
            Close cudocumentopedidoAUTO;

          ELSE

            Open cudocumentopedido(nuiditemsdoc);
            ut_trace.trace('OPEN cudocumentopedido(nuIdItemsDoc);  nuIdItemsDoc=' ||nuiditemsdoc, 10);
            Fetch cudocumentopedido Into tempcudocumentopedido;
            Close cudocumentopedido;

          END IF;
          ---FIN CAMBIO 860

					ut_trace.trace('tempcudocumentopedido.mmitnudo ' ||tempcudocumentopedido.mmitnudo, 10);

					If (tempcudocumentopedido.mmitnudo Is Not Null) Then
						if sbSumaInventario='S' then
							--Valida la existencia del documento ge_document
							Open cuexistencia(to_number(tempcudocumentopedido.mmitnudo));
							ut_trace.trace('OPEN cuexistencia(To_Number(tempcudocumentopedido.mmitnudo)); ' ||tempcudocumentopedido.mmitnudo, 10);
							--OPEN cuexistencia(nuIdItemsDoc);
							Fetch cuexistencia Into tempcuexistencia;
							---
							--validar la Recepción de Materiales de una compra
							--de materiales que viene del proveedor Logístico
							If cuexistencia%Found Then
								ut_trace.trace('cuexistencia%FOUND' , 10);
								----
								--CURSOR PARA DETERMINAR SI EL PROVEEDOR LOGISTICO ES PARA ITEMS DE ACTIVO O INVENTARIO.
								Open curactivoinventario(tempcuexistencia.provedor_logistico);
								ut_trace.trace('OPEN curACTIVOINVENTARIO(tempcuexistencia.Provedor_Logistico);  tempcuexistencia.Provedor_Logistico: ' ||tempcuexistencia.provedor_logistico, 10);
								Fetch curactivoinventario Into tempcuractivoinventario;
								Close curactivoinventario;
								--Inserta en entidad de Activos fijos
								--VALIDA SI EL CODIGO DEL PROVEEDOR LOGISITCO ESTABA CONFIGURADO PARA MANEJO DE ACTIVOS
								ut_trace.trace('TEMPcurACTIVOINVENTARIO.Lst_Centros_Sol_Act  ' ||tempcuractivoinventario.lst_centros_sol_act, 10);
								If (tempcuractivoinventario.lst_centros_sol_act > 0) Then
									ut_trace.trace('INSERT INTO ldc_act_ouib
												(items_id,
												 operating_unit_id,
												 quota,
												 balance,
												 total_costs,
												 occacional_quota,
												 transit_in,
												 transit_out)
											VALUES
												(' ||:new.items_id || ',
												 ' ||:new.operating_unit_id || ',
												 ' || :new.quota || ',
												 ' ||:new.balance || ',
												 ' ||:new.total_costs || ',
												 ' ||:new.occacional_quota || ',
												 ' ||:new.transit_in || ',
												 ' ||:new.transit_out || ');', 10);

									Insert Into open.ldc_act_ouib
									(items_id,
									 operating_unit_id,
									 quota,
									 balance,
									 total_costs,
									 occacional_quota,
									 transit_in,
									 transit_out)
									Values
									(:new.items_id,
									 :new.operating_unit_id,
									 :new.quota,
									 :new.balance,
									 :new.total_costs,
									 :new.occacional_quota,
									 :new.transit_in,
									 :new.transit_out);



									-- Cambio 6021: Se inserta registro en cero en inventarios
									Open cuexiteldc_inv_ouib;
									Fetch cuexiteldc_inv_ouib Into tempcuexiteldc_inv_ouib;
									If cuexiteldc_inv_ouib%Notfound Then
										ut_trace.trace('INSERT INTO ldc_inv_ouib
														(items_id,
														 operating_unit_id,
														 quota,
														 balance,
														 total_costs,
														 occacional_quota,
														 transit_in,
														 transit_out)
													VALUES
														(' ||:new.items_id || ',
														 ' ||:new.operating_unit_id || ',
														 0,
														 0,
														 0,
														 0,
														 0,
														 0);', 10);



										Insert Into open.ldc_inv_ouib
										  (items_id,
										   operating_unit_id,
										   quota,
										   balance,
										   total_costs,
										   occacional_quota,
										   transit_in,
										   transit_out)
										Values
										  (:new.items_id,
										   :new.operating_unit_id,
										   0,
										   0,
										   0,
										   0,
										   0,
										   0);
									End If;--If cuexiteldc_inv_ouib%Notfound Then
									Close cuexiteldc_inv_ouib;
								End If; --If (tempcuractivoinventario.lst_centros_sol_act > 0) Then
								--Inserta en entidad de Inventarios
								--VALIDA SI EL CODIGO DEL PROVEEDOR LOGISITCO ESTABA CONFIGURADO PARA MANEJO DE INVENTARIOS
								ut_trace.trace(' IF (TEMPcurACTIVOINVENTARIO.Lst_Centros_Sol_Inv > 0) THEN : ' ||tempcuractivoinventario.lst_centros_sol_inv ||' > 0)', 10);
								If (tempcuractivoinventario.lst_centros_sol_inv > 0) Then
									ut_trace.trace('INSERT INTO ldc_inv_ouib
												(items_id,
												 operating_unit_id,
												 quota,
												 balance,
												 total_costs,
												 occacional_quota,
												 transit_in,
												 transit_out)
											VALUES
												(' ||:new.items_id || ',
												 ' ||:new.operating_unit_id || ',
												 ' || :new.quota || ',
												 ' ||:new.balance || ',
												 ' ||:new.total_costs || ',
												 ' ||:new.occacional_quota || ',
												 ' ||:new.transit_in || ',
												 ' ||:new.transit_out || ');', 10);
									Insert Into open.ldc_inv_ouib
									(items_id,
									 operating_unit_id,
									 quota,
									 balance,
									 total_costs,
									 occacional_quota,
									 transit_in,
									 transit_out)
									Values
									(:new.items_id,
									 :new.operating_unit_id,
									 :new.quota,
									 :new.balance,
									 :new.total_costs,
									 :new.occacional_quota,
									 :new.transit_in,
									 :new.transit_out);

									-- Cambio 6021: Se inserta registro en cero en activos
									Open cuexiteldc_act_ouib;
									Fetch cuexiteldc_act_ouib Into tempcuexiteldc_act_ouib;
									If cuexiteldc_act_ouib%Notfound Then
										ut_trace.trace('cuexiteldc_act_ouib%NOTFOUND' , 10);
										ut_trace.trace('INSERT INTO ldc_act_ouib
														(items_id,
														 operating_unit_id,
														 quota,
														 balance,
														 total_costs,
														 occacional_quota,
														 transit_in,
														 transit_out)
													VALUES
														(' ||:new.items_id || ',
														 ' ||:new.operating_unit_id || ',
														 0,
														 0,
														 0,
														 0,
														 0,
														 0);', 10);
										Insert Into open.ldc_act_ouib
										  (items_id,
										   operating_unit_id,
										   quota,
										   balance,
										   total_costs,
										   occacional_quota,
										   transit_in,
										   transit_out)
										Values
										  (:new.items_id,
										   :new.operating_unit_id,
										   0,
										   0,
										   0,
										   0,
										   0,
										   0);
									End If; --If cuexiteldc_act_ouib%Notfound Then
									Close cuexiteldc_act_ouib;
								End If; --If (tempcuractivoinventario.lst_centros_sol_inv > 0) Then
							End If; --If cuexistencia%Found Then
							--COMMIT;
							Close cuexistencia;
						END IF;
					Else
						-- Cambio 6021 :  Se insertan los activos e inventarios al realizar la actualización en ORCOR
						Open cuexiteldc_act_ouib;
						ut_trace.trace('OPEN cuexiteldc_act_ouib;', 10 );
						Fetch cuexiteldc_act_ouib Into tempcuexiteldc_act_ouib;
						--Valida si existe el item para la unidad operativa en el activo
						If cuexiteldc_act_ouib%Notfound Then
							ut_trace.trace('cuexiteldc_act_ouib%NOTFOUND' , 10);
							ut_trace.trace('INSERT INTO ldc_act_ouib
										(items_id,
										 operating_unit_id,
										 quota,
										 balance,
										 total_costs,
										 occacional_quota,
										 transit_in,
										 transit_out)
									VALUES
										(' || :new.items_id || ',
										 ' ||:new.operating_unit_id || ',
										 0,
										 0,
										 0,
										 0,
										 0,
										 0);', 10);

							Insert Into open.ldc_act_ouib
							  (items_id,
							   operating_unit_id,
							   quota,
							   balance,
							   total_costs,
							   occacional_quota,
							   transit_in,
							   transit_out)
							Values
							  (:new.items_id, :new.operating_unit_id, 0, 0, 0, 0, 0, 0);
						End If; --If cuexiteldc_act_ouib%Notfound Then

						Close cuexiteldc_act_ouib;

						Open cuexiteldc_inv_ouib;
						Fetch cuexiteldc_inv_ouib Into tempcuexiteldc_inv_ouib;
						--Valida si existe el item para la unidad operativa en el inventario
						If cuexiteldc_inv_ouib%Notfound Then
							ut_trace.trace(' cuexiteldc_inv_ouib%NOTFOUND ' , 10);
							ut_trace.trace('INSERT INTO ldc_inv_ouib
										(items_id,
										 operating_unit_id,
										 quota,
										 balance,
										 total_costs,
										 occacional_quota,
										 transit_in,
										 transit_out)
									VALUES
										(' || :new.items_id || ',' || :new.operating_unit_id || ', 0, 0, 0, 0, 0, 0);', 10 );

							Insert Into open.ldc_inv_ouib
							  (items_id,
							   operating_unit_id,
							   quota,
							   balance,
							   total_costs,
							   occacional_quota,
							   transit_in,
							   transit_out)
							Values
							  (:new.items_id, :new.operating_unit_id, 0, 0, 0, 0, 0, 0);
						End If;--If cuexiteldc_inv_ouib%Notfound Then

						Close cuexiteldc_inv_ouib;
					End If; --If (tempcudocumentopedido.mmitnudo Is Not Null) Then fin de la validacion del documento de pedido a SAP
				End; --fin BEGIN dentro de ELSIF INSERTING THEN
			Elsif updating Then
				ut_trace.trace('UPDATING' , 10);
				or_boitemsmove.gettempvalues(nuiditemsdoc,
										   nuiditemsseriado,
										   sbestadoinv,
										   nuvalorventa,
										   nuoperunittarget,
										   nuinitstatus);
				ut_trace.trace('or_boItemsMove.getTempValues(' || nuiditemsdoc || ',
											 ' || nuiditemsseriado || ',
											 ' || sbestadoinv || ',
											 ' || nuvalorventa || ',
											 ' || nuoperunittarget || ',
											 ' || nuinitstatus || ');', 10);


				--Obtiene el codigo de documento de la instancia
				nuiditemsdoc := nvl(nuiditemsdoc, 0);
				ut_trace.trace('nuIdItemsDoc ' || nuiditemsdoc , 10);
				--VALIDACION 3
				--VERIFICAR SI LA TABLA ACTUALIZA ITEMS QUE NO PROVENGA DE UNA ORDEN LEGALIZADA.
				--INDICA QUE PROVIENE DE SAP O DE TRANSALADO DE ITEMS ENTRE BODEGAS.
				--/*--Actualizacion de compra materiales SAP. ya que SAP mediante smartflex
				--ACTUALIZA LOS ITEMS. esto mediante la relacion de un documneto
				/* INSERT INTO LDC_MENSAJES VALUES ('UPDATING', SYSDATE);
				INSERT INTO LDC_MENSAJES
				VALUES
				('ITEM [' || :NEW.items_id || '] - UNIDAD OPERATIVA [' ||
				 :NEW.operating_unit_id || ']',
				 SYSDATE);*/
				Begin

          --INICIO CAMBIO 860
          IF FBLAPLICAENTREGAXCASO('0000860') THEN

            Open cudocumentopedidoAUTO (nuiditemsdoc);
            ut_trace.trace('OPEN cudocumentopedidoAUTO(nuIdItemsDoc);  nuIdItemsDoc=' ||nuiditemsdoc, 10);
            Fetch cudocumentopedidoAUTO Into tempcudocumentopedido;
            Close cudocumentopedidoAUTO;

          ELSE

            Open cudocumentopedido(nuiditemsdoc);
            ut_trace.trace('OPEN cudocumentopedido(' || nuiditemsdoc || ');', 10);
            Fetch cudocumentopedido Into tempcudocumentopedido;
            Close cudocumentopedido;

          END IF;
          ---FIN CAMBIO 860

					--Valida si existe un documento de perido SAP
					if sbSumaInventario='S' then
						If (tempcudocumentopedido.mmitnudo Is Not Null Or tempcudocumentopedido.id_items_documento Is Not Null) Then
							If (tempcudocumentopedido.mmitnudo Is Not Null And
								nuiditemsdocexiste Is Null) Then
								nuiditemsdocexiste := tempcudocumentopedido.mmitnudo;
							End If;

							If (tempcudocumentopedido.id_items_documento Is Not Null And
								nuiditemsdocexiste Is Null) Then
								nuiditemsdocexiste := tempcudocumentopedido.id_items_documento;
							End If;
							------INSERT INTO LDC_MENSAJES (mensaje,fecha) VALUES  ('OR_OPE_UNI_ITEM_BALA UPDATING control 3 tempcudocumentopedido.mmitnudo '||tempcudocumentopedido.mmitnudo,SYSDATE);
							------INSERT INTO LDC_MENSAJES (mensaje,fecha) VALUES  ('OR_OPE_UNI_ITEM_BALA UPDATING control 3 nuIdItemsDocExiste'||nuIdItemsDocExiste,SYSDATE);
							--Valida la exitencia de un documento por Recepcion de material desde SAP
							Open cuexistencia(to_number(nuiditemsdocexiste));
							ut_trace.trace('OPEN cuexistencia(To_Number(' ||nuiditemsdocexiste || '))', 10);
							Fetch cuexistencia Into tempcuexistencia;
							--Valida la exixtencia de un pedido de venta
							Open cuexistenciaventa(to_number(nuiditemsdocexiste));
							ut_trace.trace('OPEN cuexistenciaVenta(To_Number(' ||nuiditemsdocexiste || ')); ', 10);
							Fetch cuexistenciaventa Into tempcuexistenciaventa;
							---Valida la existencia de un documento por Anulacion  desde SAP
							Open cuexistenciaanulacion(to_number(nuiditemsdocexiste));
							ut_trace.trace('OPEN cuexistenciaAnulacion(To_Number(' || nuiditemsdocexiste || '));', 10);
							Fetch cuexistenciaanulacion Into tempcuexistenciaanulacion;
							--validar la Recepción de Materiales de una compra
							--de materiales que viene del proveedor Logístico
							--esto para los tipsod e documento 102 y  101 que se generan en OSF
							--PAra el tipo de documento 104 Se genera cuando se realiza una anulacion
							--Para esto se crea un campo tipo signo para indicar  si debe sumar o restar
							-- en las bodegas
							--Se agrega la validacino de laexitenciad e un documento de anulacino desde SAP
							/*INSERT INTO LDC_MENSAJES
							VALUES
							('Provedor Logistico [' || tempcuexistencia.Provedor_Logistico || ']',
							 SYSDATE);*/

							If (cuexistencia%Found Or cuexistenciaanulacion%Found Or cuexistenciaventa%Found) Then
								--Valida si el moviento de SAP + o -
								--Los mmovientos de cuexistencia +
								--los movimietnos de cuexistenciaAnulacion -


								If (cuexistenciaventa%Found) Then
									tempcuexistencia := tempcuexistenciaventa;
								End If;

								If (cuexistenciaanulacion%Found) Then
									tempcuexistencia := tempcuexistenciaanulacion;
								End If;

								----
								-----INSERT INTO LDC_MENSAJES (mensaje,fecha) VALUES  ('OR_OPE_UNI_ITEM_BALA UPDATING control 3.1 '||tempcuexistencia.Provedor_Logistico,SYSDATE);

								Open curactivoinventario(tempcuexistencia.provedor_logistico);
								ut_trace.trace('OPEN curACTIVOINVENTARIO(' ||tempcuexistencia.provedor_logistico || ')', 10);
								Fetch curactivoinventario Into tempcuractivoinventario;
								Close curactivoinventario;

								--Inserta en entidad de Activos fijos
								ut_trace.trace('TEMPcurACTIVOINVENTARIO.Lst_Centros_Sol_Act ' ||tempcuractivoinventario.lst_centros_sol_act, 10);

								If (tempcuractivoinventario.lst_centros_sol_act > 0) Then
									-----INSERT INTO LDC_MENSAJES (mensaje,fecha) VALUES  ('OR_OPE_UNI_ITEM_BALA UPDATING control 3.1.1 '||TEMPcurACTIVOINVENTARIO.Lst_Centros_Sol_Act,SYSDATE);
									--Valida si existe en la tabla de bodega de activos
									Open cuexiteldc_act_ouib;
									Fetch cuexiteldc_act_ouib Into tempcuexiteldc_act_ouib;
									If cuexiteldc_act_ouib%Found Then
										ut_trace.trace('cuexiteldc_act_ouib%FOUND ', 10 );
										--Valida que la diferencia del balance sea
										--manor igual al balance del activo
										ut_trace.trace('IF ((' || :old.balance || ' - (' ||:new.balance ||')) <=' ||tempcuexiteldc_act_ouib.balance ||') THEN', 10);
										If ((:old.balance - (:new.balance)) <= tempcuexiteldc_act_ouib.balance) Then
											-----INSERT INTO LDC_MENSAJES (mensaje,fecha) VALUES  ('OR_OPE_UNI_ITEM_BALA UPDATING control 3.1.1.2 '||to_char(:OLD.balance - :NEW.balance),SYSDATE);
											Update open.ldc_act_ouib
											 Set total_costs      = total_costs + ((:new.total_costs) -:old.total_costs),
												 quota            = :new.quota,
												 balance          = balance +((:new.balance) - :old.balance),
												 occacional_quota = :new.occacional_quota,
												 transit_in       = :new.transit_in,
												 transit_out      = :new.transit_out
											Where items_id = :new.items_id
											 And operating_unit_id = :new.operating_unit_id;

											ut_trace.trace('  UPDATE ldc_act_ouib
															SET    total_costs = total_costs +((' ||:new.total_costs || ') - ' ||:old.total_costs || ')
															WHERE  items_id = ' ||:new.items_id || '
															AND    operating_unit_id = ' ||:new.operating_unit_id || ';', 10);
											--INSERT INTO LDC_ITEMS_DOCUMENTO
											--VALUES
											--  (tempcuexistencia.Codigo_Documento);
										Else
											raise_application_error(-20998,'En la bodega existen ' ||to_char(:old.balance) ||' pero solo ' ||to_char(nusaldouo) ||' para Activos');
											Raise ex.controlled_error;
										End If;--((:old.balance - (:new.balance)) <= tempcuexiteldc_act_ouib.balance) Then
									Else
										-----INSERT INTO LDC_MENSAJES (mensaje,fecha) VALUES  ('OR_OPE_UNI_ITEM_BALA UPDATING control 3.1.1.3 '||nuIdItemsDoc,SYSDATE);
										--sino existe el registro en activos se debe insertar con la cantidad
										--que desea actualizar Proveedor_logistico
										ut_trace.trace(' INSERT INTO ldc_act_ouib
														(items_id,
														 operating_unit_id,
														 quota,
														 balance,
														 total_costs,
														 occacional_quota,
														 transit_in,
														 transit_out)
													VALUES
														(' ||:new.items_id || ',
														 ' ||:new.operating_unit_id || ',
														 ' ||:new.quota || ',
														 ((' ||:new.balance || ') - ' || :old.balance || '),
														 ((' ||:new.total_costs || ') - ' ||:old.total_costs || '),
														 ' ||:new.occacional_quota || ',
														 ' ||:new.transit_in || ',
														 ' ||:new.transit_out || ');', 10);
										Insert Into open.ldc_act_ouib
										  (items_id,
										   operating_unit_id,
										   quota,
										   balance,
										   total_costs,
										   occacional_quota,
										   transit_in,
										   transit_out)
										Values
										  (:new.items_id,
										   :new.operating_unit_id,
										   :new.quota,
										   ((:new.balance) - :old.balance),
										   ((:new.total_costs) - :old.total_costs),
										   :new.occacional_quota,
										   :new.transit_in,
										   :new.transit_out);

										-- Cambio 6021: Se inserta registro en cero en inventarios
										--Valida si existe en la bodega de inventarios
										Open cuexiteldc_inv_ouib;
										Fetch cuexiteldc_inv_ouib Into tempcuexiteldc_inv_ouib;
										If cuexiteldc_inv_ouib%Notfound Then
											-----INSERT INTO LDC_MENSAJES (mensaje,fecha) VALUES  ('OR_OPE_UNI_ITEM_BALA UPDATING control 3.1.1.3.1 '||nuIdItemsDoc,SYSDATE);

											ut_trace.trace('INSERT INTO ldc_inv_ouib
															(items_id,
															 operating_unit_id,
															 quota,
															 balance,
															 total_costs,
															 occacional_quota,
															 transit_in,
															 transit_out)
														VALUES
															(' ||:new.items_id || ',
															 ' ||:new.operating_unit_id || ',
															 0,
															 0,
															 0,
															 0,
															 0,
															 0);', 10);

											Insert Into open.ldc_inv_ouib
											(items_id,
											 operating_unit_id,
											 quota,
											 balance,
											 total_costs,
											 occacional_quota,
											 transit_in,
											 transit_out)
											Values
											(:new.items_id,
											 :new.operating_unit_id,
											 0,
											 0,
											 0,
											 0,
											 0,
											 0);
										End If; --If cuexiteldc_inv_ouib%Notfound Then
										Close cuexiteldc_inv_ouib;

										--INSERT INTO LDC_ITEMS_DOCUMENTO
										--VALUES
										--  (tempcuexistencia.Codigo_Documento);
									End If; --If cuexiteldc_act_ouib%Found Then
									Close cuexiteldc_act_ouib;
								End If; --If (tempcuractivoinventario.lst_centros_sol_act > 0) Then

								--Inserta en entidad de Inventarios
								If (tempcuractivoinventario.lst_centros_sol_inv > 0) Then

									ut_trace.trace('TEMPcurACTIVOINVENTARIO.Lst_Centros_Sol_Inv ' || tempcuractivoinventario.lst_centros_sol_inv, 10);
									-----INSERT INTO LDC_MENSAJES (mensaje,fecha) VALUES  ('OR_OPE_UNI_ITEM_BALA UPDATING control 3.1.2.0'||nuIdItemsDoc,SYSDATE);
									--Valida si existe en la bodega de activos
									Open cuexiteldc_inv_ouib;
									Fetch cuexiteldc_inv_ouib Into tempcuexiteldc_inv_ouib;
									If cuexiteldc_inv_ouib%Found Then
										ut_trace.trace('cuexiteldc_inv_ouib%FOUND' , 10);
										-----INSERT INTO LDC_MENSAJES (mensaje,fecha) VALUES  ('OR_OPE_UNI_ITEM_BALA UPDATING control 3.1.2.1'||nuIdItemsDoc,SYSDATE);
										ut_trace.trace('(:OLD.balance - (:NEW.balance)) <=tempcuexiteldc_inv_ouib.balance)   (' ||:old.balance || ' - (' || :new.balance ||')) <=' ||tempcuexiteldc_inv_ouib.balance || ')', 10);
										If ((:old.balance - (:new.balance)) <=tempcuexiteldc_inv_ouib.balance) Then
											-----INSERT INTO LDC_MENSAJES (mensaje,fecha) VALUES  ('OR_OPE_UNI_ITEM_BALA UPDATING control 3.1.2.1.1'||nuIdItemsDoc,SYSDATE);

											Update open.ldc_inv_ouib
											 Set total_costs      = total_costs + ((:new.total_costs) -:old.total_costs),
												 quota            = :new.quota,
												 balance          = balance + ((:new.balance) - :old.balance),
												 occacional_quota = :new.occacional_quota,
												 transit_in       = :new.transit_in,
												 transit_out      = :new.transit_out
											Where items_id = :new.items_id
											 And operating_unit_id = :new.operating_unit_id;

											--INSERT INTO LDC_ITEMS_DOCUMENTO
											--VALUES
											--  (tempcuexistencia.Codigo_Documento);
										Else
											raise_application_error(-20996,'En la bodega existen ' ||to_char(:old.balance) ||' pero solo ' ||to_char(nusaldouo) ||' para Inventarios');
											Raise ex.controlled_error;
										End If; --If ((:old.balance - (:new.balance)) <=tempcuexiteldc_inv_ouib.balance) Then

									Else
										-----INSERT INTO LDC_MENSAJES (mensaje,fecha) VALUES  ('OR_OPE_UNI_ITEM_BALA UPDATING control 3.1.2.2'||nuIdItemsDoc,SYSDATE);
										ut_trace.trace('INSERT INTO ldc_inv_ouib
														(items_id,
														 operating_unit_id,
														 quota,
														 balance,
														 total_costs,
														 occacional_quota,
														 transit_in,
														 transit_out)
													VALUES
														(' ||:new.items_id || ',
														 ' ||:new.operating_unit_id || ',
														 ' ||:new.quota || ',
														 ((' ||:new.balance || ') - ' || :old.balance || '),
														 ((' ||:new.total_costs || ') - ' ||:old.total_costs || '),
														 ' ||:new.occacional_quota || ',
														 ' ||:new.transit_in || ',
														 ' ||:new.transit_out || ');', 10);


										Insert Into open.ldc_inv_ouib
										  (items_id,
										   operating_unit_id,
										   quota,
										   balance,
										   total_costs,
										   occacional_quota,
										   transit_in,
										   transit_out)
										Values
										  (:new.items_id,
										   :new.operating_unit_id,
										   :new.quota,
										   ((:new.balance) - :old.balance),
										   ((:new.total_costs) - :old.total_costs),
										   :new.occacional_quota,
										   :new.transit_in,
										   :new.transit_out);

										-- Cambio 6021: Se inserta registro en cero en activos
										--Valida si existe en la bodega de inventarios
										Open cuexiteldc_act_ouib;
										Fetch cuexiteldc_act_ouib Into tempcuexiteldc_act_ouib;
										If cuexiteldc_act_ouib%Notfound Then
											ut_trace.trace('cuexiteldc_act_ouib%NOTFOUND ' , 10);
											-----INSERT INTO LDC_MENSAJES (mensaje,fecha) VALUES  ('OR_OPE_UNI_ITEM_BALA UPDATING control 3.1.2.3'||nuIdItemsDoc,SYSDATE);
											ut_trace.trace('INSERT INTO ldc_act_ouib
															(items_id,
															 operating_unit_id,
															 quota,
															 balance,
															 total_costs,
															 occacional_quota,
															 transit_in,
															 transit_out)
														VALUES
															(' ||:new.items_id || ',
															 ' ||:new.operating_unit_id || ',
															 0,
															 0,
															 0,
															 0,
															 0,
															 0);', 10);

											Insert Into open.ldc_act_ouib
											(items_id,
											 operating_unit_id,
											 quota,
											 balance,
											 total_costs,
											 occacional_quota,
											 transit_in,
											 transit_out)
											Values
											(:new.items_id,
											 :new.operating_unit_id,
											 0,
											 0,
											 0,
											 0,
											 0,
											 0);
										End If; --If cuexiteldc_act_ouib%Notfound Then
										Close cuexiteldc_act_ouib;

										--INSERT INTO LDC_ITEMS_DOCUMENTO
										--VALUES
										--  (tempcuexistencia.Codigo_Documento);
									End If; --If cuexiteldc_inv_ouib%Found Then
									Close cuexiteldc_inv_ouib;
								End If; --If (tempcuractivoinventario.lst_centros_sol_inv > 0) Then
							End If;--If (cuexistencia%Found Or cuexistenciaanulacion%Found Or cuexistenciaventa%Found) Then
							Close cuexistencia;
							Close cuexistenciaanulacion;
							Close cuexistenciaventa;
						End If; --If (tempcudocumentopedido.mmitnudo Is Not Null Or tempcudocumentopedido.id_items_documento Is Not Null) Then fin de la validacion del documento de pedido a SAP
					else
            If (tempcudocumentopedido.mmitnudo Is Not Null ) Then
							If (tempcudocumentopedido.mmitnudo Is Not Null And
								nuiditemsdocexiste Is Null) Then
								nuiditemsdocexiste := tempcudocumentopedido.mmitnudo;
							End If;

							If (tempcudocumentopedido.id_items_documento Is Not Null And
								nuiditemsdocexiste Is Null) Then
								nuiditemsdocexiste := tempcudocumentopedido.id_items_documento;
							End If;
							------INSERT INTO LDC_MENSAJES (mensaje,fecha) VALUES  ('OR_OPE_UNI_ITEM_BALA UPDATING control 3 tempcudocumentopedido.mmitnudo '||tempcudocumentopedido.mmitnudo,SYSDATE);
							------INSERT INTO LDC_MENSAJES (mensaje,fecha) VALUES  ('OR_OPE_UNI_ITEM_BALA UPDATING control 3 nuIdItemsDocExiste'||nuIdItemsDocExiste,SYSDATE);
							--Valida la exitencia de un documento por Recepcion de material desde SAP
							Open cuexistencia(to_number(nuiditemsdocexiste));
							ut_trace.trace('OPEN cuexistencia(To_Number(' ||nuiditemsdocexiste || '))', 10);
							Fetch cuexistencia Into tempcuexistencia;
							--Valida la exixtencia de un pedido de venta
							Open cuexistenciaventa(to_number(nuiditemsdocexiste));
							ut_trace.trace('OPEN cuexistenciaVenta(To_Number(' ||nuiditemsdocexiste || ')); ', 10);
							Fetch cuexistenciaventa Into tempcuexistenciaventa;
							---Valida la existencia de un documento por Anulacion  desde SAP
							Open cuexistenciaanulacion(to_number(nuiditemsdocexiste));
							ut_trace.trace('OPEN cuexistenciaAnulacion(To_Number(' || nuiditemsdocexiste || '));', 10);
							Fetch cuexistenciaanulacion Into tempcuexistenciaanulacion;
							--validar la Recepción de Materiales de una compra
							--de materiales que viene del proveedor Logístico
							--esto para los tipsod e documento 102 y  101 que se generan en OSF
							--PAra el tipo de documento 104 Se genera cuando se realiza una anulacion
							--Para esto se crea un campo tipo signo para indicar  si debe sumar o restar
							-- en las bodegas
							--Se agrega la validacino de laexitenciad e un documento de anulacino desde SAP
							/*INSERT INTO LDC_MENSAJES
							VALUES
							('Provedor Logistico [' || tempcuexistencia.Provedor_Logistico || ']',
							 SYSDATE);*/

							If (cuexistencia%Found Or cuexistenciaanulacion%Found Or cuexistenciaventa%Found) Then
								--Valida si el moviento de SAP + o -
								--Los mmovientos de cuexistencia +
								--los movimietnos de cuexistenciaAnulacion -


								If (cuexistenciaventa%Found) Then
									tempcuexistencia := tempcuexistenciaventa;
								End If;

								If (cuexistenciaanulacion%Found) Then
									tempcuexistencia := tempcuexistenciaanulacion;
								End If;

								----
								-----INSERT INTO LDC_MENSAJES (mensaje,fecha) VALUES  ('OR_OPE_UNI_ITEM_BALA UPDATING control 3.1 '||tempcuexistencia.Provedor_Logistico,SYSDATE);

								Open curactivoinventario(tempcuexistencia.provedor_logistico);
								ut_trace.trace('OPEN curACTIVOINVENTARIO(' ||tempcuexistencia.provedor_logistico || ')', 10);
								Fetch curactivoinventario Into tempcuractivoinventario;
								Close curactivoinventario;

								--Inserta en entidad de Activos fijos
								ut_trace.trace('TEMPcurACTIVOINVENTARIO.Lst_Centros_Sol_Act ' ||tempcuractivoinventario.lst_centros_sol_act, 10);

								If (tempcuractivoinventario.lst_centros_sol_act > 0) Then
									-----INSERT INTO LDC_MENSAJES (mensaje,fecha) VALUES  ('OR_OPE_UNI_ITEM_BALA UPDATING control 3.1.1 '||TEMPcurACTIVOINVENTARIO.Lst_Centros_Sol_Act,SYSDATE);
									--Valida si existe en la tabla de bodega de activos
									Open cuexiteldc_act_ouib;
									Fetch cuexiteldc_act_ouib Into tempcuexiteldc_act_ouib;
									If cuexiteldc_act_ouib%Found Then
										ut_trace.trace('cuexiteldc_act_ouib%FOUND ', 10 );
										--Valida que la diferencia del balance sea
										--manor igual al balance del activo
										ut_trace.trace('IF ((' || :old.balance || ' - (' ||:new.balance ||')) <=' ||tempcuexiteldc_act_ouib.balance ||') THEN', 10);
										If ((:old.balance - (:new.balance)) <= tempcuexiteldc_act_ouib.balance) Then
											-----INSERT INTO LDC_MENSAJES (mensaje,fecha) VALUES  ('OR_OPE_UNI_ITEM_BALA UPDATING control 3.1.1.2 '||to_char(:OLD.balance - :NEW.balance),SYSDATE);
											Update open.ldc_act_ouib
											 Set total_costs      = total_costs + ((:new.total_costs) -:old.total_costs),
												 quota            = :new.quota,
												 balance          = balance +((:new.balance) - :old.balance),
												 occacional_quota = :new.occacional_quota,
												 transit_in       = :new.transit_in,
												 transit_out      = :new.transit_out
											Where items_id = :new.items_id
											 And operating_unit_id = :new.operating_unit_id;

											ut_trace.trace('  UPDATE ldc_act_ouib
															SET    total_costs = total_costs +((' ||:new.total_costs || ') - ' ||:old.total_costs || ')
															WHERE  items_id = ' ||:new.items_id || '
															AND    operating_unit_id = ' ||:new.operating_unit_id || ';', 10);
											--INSERT INTO LDC_ITEMS_DOCUMENTO
											--VALUES
											--  (tempcuexistencia.Codigo_Documento);
										Else
											raise_application_error(-20998,'En la bodega existen ' ||to_char(:old.balance) ||' pero solo ' ||to_char(nusaldouo) ||' para Activos');
											Raise ex.controlled_error;
										End If;--((:old.balance - (:new.balance)) <= tempcuexiteldc_act_ouib.balance) Then
									Else
										-----INSERT INTO LDC_MENSAJES (mensaje,fecha) VALUES  ('OR_OPE_UNI_ITEM_BALA UPDATING control 3.1.1.3 '||nuIdItemsDoc,SYSDATE);
										--sino existe el registro en activos se debe insertar con la cantidad
										--que desea actualizar Proveedor_logistico
										ut_trace.trace(' INSERT INTO ldc_act_ouib
														(items_id,
														 operating_unit_id,
														 quota,
														 balance,
														 total_costs,
														 occacional_quota,
														 transit_in,
														 transit_out)
													VALUES
														(' ||:new.items_id || ',
														 ' ||:new.operating_unit_id || ',
														 ' ||:new.quota || ',
														 ((' ||:new.balance || ') - ' || :old.balance || '),
														 ((' ||:new.total_costs || ') - ' ||:old.total_costs || '),
														 ' ||:new.occacional_quota || ',
														 ' ||:new.transit_in || ',
														 ' ||:new.transit_out || ');', 10);
										Insert Into open.ldc_act_ouib
										  (items_id,
										   operating_unit_id,
										   quota,
										   balance,
										   total_costs,
										   occacional_quota,
										   transit_in,
										   transit_out)
										Values
										  (:new.items_id,
										   :new.operating_unit_id,
										   :new.quota,
										   ((:new.balance) - :old.balance),
										   ((:new.total_costs) - :old.total_costs),
										   :new.occacional_quota,
										   :new.transit_in,
										   :new.transit_out);

										-- Cambio 6021: Se inserta registro en cero en inventarios
										--Valida si existe en la bodega de inventarios
										Open cuexiteldc_inv_ouib;
										Fetch cuexiteldc_inv_ouib Into tempcuexiteldc_inv_ouib;
										If cuexiteldc_inv_ouib%Notfound Then
											-----INSERT INTO LDC_MENSAJES (mensaje,fecha) VALUES  ('OR_OPE_UNI_ITEM_BALA UPDATING control 3.1.1.3.1 '||nuIdItemsDoc,SYSDATE);

											ut_trace.trace('INSERT INTO ldc_inv_ouib
															(items_id,
															 operating_unit_id,
															 quota,
															 balance,
															 total_costs,
															 occacional_quota,
															 transit_in,
															 transit_out)
														VALUES
															(' ||:new.items_id || ',
															 ' ||:new.operating_unit_id || ',
															 0,
															 0,
															 0,
															 0,
															 0,
															 0);', 10);

											Insert Into open.ldc_inv_ouib
											(items_id,
											 operating_unit_id,
											 quota,
											 balance,
											 total_costs,
											 occacional_quota,
											 transit_in,
											 transit_out)
											Values
											(:new.items_id,
											 :new.operating_unit_id,
											 0,
											 0,
											 0,
											 0,
											 0,
											 0);
										End If; --If cuexiteldc_inv_ouib%Notfound Then
										Close cuexiteldc_inv_ouib;

										--INSERT INTO LDC_ITEMS_DOCUMENTO
										--VALUES
										--  (tempcuexistencia.Codigo_Documento);
									End If; --If cuexiteldc_act_ouib%Found Then
									Close cuexiteldc_act_ouib;
								End If; --If (tempcuractivoinventario.lst_centros_sol_act > 0) Then

								--Inserta en entidad de Inventarios
								If (tempcuractivoinventario.lst_centros_sol_inv > 0) Then

									ut_trace.trace('TEMPcurACTIVOINVENTARIO.Lst_Centros_Sol_Inv ' || tempcuractivoinventario.lst_centros_sol_inv, 10);
									-----INSERT INTO LDC_MENSAJES (mensaje,fecha) VALUES  ('OR_OPE_UNI_ITEM_BALA UPDATING control 3.1.2.0'||nuIdItemsDoc,SYSDATE);
									--Valida si existe en la bodega de activos
									Open cuexiteldc_inv_ouib;
									Fetch cuexiteldc_inv_ouib Into tempcuexiteldc_inv_ouib;
									If cuexiteldc_inv_ouib%Found Then
										ut_trace.trace('cuexiteldc_inv_ouib%FOUND' , 10);
										-----INSERT INTO LDC_MENSAJES (mensaje,fecha) VALUES  ('OR_OPE_UNI_ITEM_BALA UPDATING control 3.1.2.1'||nuIdItemsDoc,SYSDATE);
										ut_trace.trace('(:OLD.balance - (:NEW.balance)) <=tempcuexiteldc_inv_ouib.balance)   (' ||:old.balance || ' - (' || :new.balance ||')) <=' ||tempcuexiteldc_inv_ouib.balance || ')', 10);
										If ((:old.balance - (:new.balance)) <=tempcuexiteldc_inv_ouib.balance) Then
											-----INSERT INTO LDC_MENSAJES (mensaje,fecha) VALUES  ('OR_OPE_UNI_ITEM_BALA UPDATING control 3.1.2.1.1'||nuIdItemsDoc,SYSDATE);

											Update open.ldc_inv_ouib
											 Set total_costs      = total_costs + ((:new.total_costs) -:old.total_costs),
												 quota            = :new.quota,
												 balance          = balance + ((:new.balance) - :old.balance),
												 occacional_quota = :new.occacional_quota,
												 transit_in       = :new.transit_in,
												 transit_out      = :new.transit_out
											Where items_id = :new.items_id
											 And operating_unit_id = :new.operating_unit_id;

											--INSERT INTO LDC_ITEMS_DOCUMENTO
											--VALUES
											--  (tempcuexistencia.Codigo_Documento);
										Else
											raise_application_error(-20996,'En la bodega existen ' ||to_char(:old.balance) ||' pero solo ' ||to_char(nusaldouo) ||' para Inventarios');
											Raise ex.controlled_error;
										End If; --If ((:old.balance - (:new.balance)) <=tempcuexiteldc_inv_ouib.balance) Then

									Else
										-----INSERT INTO LDC_MENSAJES (mensaje,fecha) VALUES  ('OR_OPE_UNI_ITEM_BALA UPDATING control 3.1.2.2'||nuIdItemsDoc,SYSDATE);
										ut_trace.trace('INSERT INTO ldc_inv_ouib
														(items_id,
														 operating_unit_id,
														 quota,
														 balance,
														 total_costs,
														 occacional_quota,
														 transit_in,
														 transit_out)
													VALUES
														(' ||:new.items_id || ',
														 ' ||:new.operating_unit_id || ',
														 ' ||:new.quota || ',
														 ((' ||:new.balance || ') - ' || :old.balance || '),
														 ((' ||:new.total_costs || ') - ' ||:old.total_costs || '),
														 ' ||:new.occacional_quota || ',
														 ' ||:new.transit_in || ',
														 ' ||:new.transit_out || ');', 10);


										Insert Into open.ldc_inv_ouib
										  (items_id,
										   operating_unit_id,
										   quota,
										   balance,
										   total_costs,
										   occacional_quota,
										   transit_in,
										   transit_out)
										Values
										  (:new.items_id,
										   :new.operating_unit_id,
										   :new.quota,
										   ((:new.balance) - :old.balance),
										   ((:new.total_costs) - :old.total_costs),
										   :new.occacional_quota,
										   :new.transit_in,
										   :new.transit_out);

										-- Cambio 6021: Se inserta registro en cero en activos
										--Valida si existe en la bodega de inventarios
										Open cuexiteldc_act_ouib;
										Fetch cuexiteldc_act_ouib Into tempcuexiteldc_act_ouib;
										If cuexiteldc_act_ouib%Notfound Then
											ut_trace.trace('cuexiteldc_act_ouib%NOTFOUND ' , 10);
											-----INSERT INTO LDC_MENSAJES (mensaje,fecha) VALUES  ('OR_OPE_UNI_ITEM_BALA UPDATING control 3.1.2.3'||nuIdItemsDoc,SYSDATE);
											ut_trace.trace('INSERT INTO ldc_act_ouib
															(items_id,
															 operating_unit_id,
															 quota,
															 balance,
															 total_costs,
															 occacional_quota,
															 transit_in,
															 transit_out)
														VALUES
															(' ||:new.items_id || ',
															 ' ||:new.operating_unit_id || ',
															 0,
															 0,
															 0,
															 0,
															 0,
															 0);', 10);

											Insert Into open.ldc_act_ouib
											(items_id,
											 operating_unit_id,
											 quota,
											 balance,
											 total_costs,
											 occacional_quota,
											 transit_in,
											 transit_out)
											Values
											(:new.items_id,
											 :new.operating_unit_id,
											 0,
											 0,
											 0,
											 0,
											 0,
											 0);
										End If; --If cuexiteldc_act_ouib%Notfound Then
										Close cuexiteldc_act_ouib;

										--INSERT INTO LDC_ITEMS_DOCUMENTO
										--VALUES
										--  (tempcuexistencia.Codigo_Documento);
									End If; --If cuexiteldc_inv_ouib%Found Then
									Close cuexiteldc_inv_ouib;
								End If; --If (tempcuractivoinventario.lst_centros_sol_inv > 0) Then
							End If;--If (cuexistencia%Found Or cuexistenciaanulacion%Found Or cuexistenciaventa%Found) Then
							Close cuexistencia;
							Close cuexistenciaanulacion;
							Close cuexistenciaventa;
						End If; --If (tempcudocumentopedido.mmitnudo Is Not Null Or tempcudocumentopedido.id_items_documento Is Not Null) Then fin de la validacion del documento de pedido a SAP

					end if;--sbSumaInventario='S'
				End;
			Elsif deleting Then
				ut_trace.trace('deleting' , 10);
				Begin
					--Borra registro en Activos fijos
					ut_trace.trace('DELETE FROM ldc_act_ouib
									WHERE  items_id = ' || :old.items_id || '
									AND    operating_unit_id = ' ||:old.operating_unit_id || ';', 10);

					Delete From open.ldc_act_ouib
					Where items_id = :old.items_id
					And operating_unit_id = :old.operating_unit_id;

					--Borra registro en Inventarios
					ut_trace.trace('DELETE FROM ldc_inv_ouib
									WHERE  items_id = ' || :old.items_id || '
									AND    operating_unit_id = ' ||
									:old.operating_unit_id || ';', 10);

					Delete From open.ldc_inv_ouib
					Where items_id = :old.items_id
					And operating_unit_id = :old.operating_unit_id;

					--COMMIT;
				Exception
					When Others Then
						nuregafect := 0;
						raise_application_error(-20991,
						'Se presentó un error eliminando registro en bodega.');
						Raise;
				End;
			End If; --If (daor_order.fblexist(nuorderid)) Then
		End If; --If :old.balance = :new.balance And :old.quota = :new.quota And
				--:old.total_costs <> :new.total_costs And
				--:old.occacional_quota = :new.occacional_quota And
				--:old.transit_in = :new.transit_in And
				--:old.transit_out = :new.transit_out And :old.items_id = :new.items_id And
				--:old.operating_unit_id = :new.operating_unit_id Then
		--      END IF;
		--FIN Inserción de compra materiales SAP  */
		/*If updating Or inserting Then
		Begin
		  Select (i.balance + a.balance),
				 (i.total_costs + a.operating_unit_id)
			Into nubalance, total_costs
			From ldc_inv_ouib i, ldc_act_ouib a
		   Where i.items_id = a.items_id
			 And i.operating_unit_id = a.operating_unit_id
			 And (i.items_id = :new.items_id Or a.items_id = :new.items_id)
			 And (i.operating_unit_id = :new.operating_unit_id Or
				 a.operating_unit_id = :new.operating_unit_id);
		Exception
		  When no_data_found Then
			nubalance   := 0;
			total_costs := 0;
		  When Others Then
			nubalance   := 0;
			total_costs := 0;
		End;

		If :new.balance <> nubalance Then
		  :new.balance := nubalance;
		End If;

		If :new.total_costs <> total_costs Then
		  :new.total_costs := total_costs;
		End If;
		End If;
		*/
	end if; --If :old.balance = :new.balance And :old.quota = :new.quota And
			--:old.total_costs = :new.total_costs And
			--:old.occacional_quota = :new.occacional_quota And
			--:old.transit_in = :new.transit_in And
			--:old.transit_out = :new.transit_out And
			--:old.items_id = :new.items_id And
			--:old.operating_unit_id = :new.operating_unit_id Then --CA 200-833 se adiciona condicion para que no se dispare el trigger multiples veces.

Exception
	When ex.controlled_error Then
		Raise;
		--NULL;
	When Others Then
		pkerrors.geterrorvar(nuerrcode, sberrmsg);
End ldctrgbudi_or_ouib;
/
