CREATE OR REPLACE PACKAGE adm_person.LDC_PKGASIGNARCONT IS
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : 
    Descripcion	 : 
    
    Parametro	    Descripcion
    ============	==============================
    
    Historia de Modificaciones
    Fecha   	           Autor            Modificacion
    ====================   =========        ====================
    15/07/2024              PAcosta         OSF-2885: Cambio de esquema ADM_PERSON 
                                            Retiro marcacion esquema .open objetos de lógica
    ****************************************************************/                                        
 
 FUNCTION FSBVERSION   RETURN VARCHAR2;

 PROCEDURE proAsignarContratoMigr (nuOrden   IN or_order.order_id%TYPE,
								   nuOrdenPadre  IN or_order.order_id%TYPE,
								   nuEstadootPa	 IN or_order.order_status_id%TYPE,
								   nuCausal      in ge_causal.causal_id%type,
								   nuUnidad   IN or_order.OPERATING_UNIT_ID%TYPE,
								   nuTipoTrab IN or_order.task_type_id%TYPE,
								   nuActividad  IN ge_items.items_id%TYPE,
								   dtfechaAsig  IN DATE,
								   nuContrato OUT ge_contrato.id_contrato%TYPE,
								   nuOk       OUT NUMBER,
								   sbError    OUT VARCHAR2);

 PROCEDURE proAsignarContrato (nuOrden   IN or_order.order_id%TYPE,
                               nuOrdenPadre  IN or_order.order_id%TYPE,
							   nuEstadootPa	 IN or_order.order_status_id%TYPE,
                               nuCausal      in ge_causal.causal_id%type,
                               nuUnidad   IN or_order.OPERATING_UNIT_ID%TYPE,
                               nuTipoTrab IN or_order.task_type_id%TYPE,
                               nuActividad  IN ge_items.items_id%TYPE,
                               nuContrato OUT ge_contrato.id_contrato%TYPE,
                               nuOk       OUT NUMBER,
                               sbError    OUT VARCHAR2);
  /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2017-04-07
      Ticket      : 200-810
      Descripcion : Procedimiento que asigna contrato a orden

      Parametros Entrada
      nuOrden  numero de la orden
      nuUnidad  unidad operativa de la orden
      nuTipoTrab tipo de trabajo

      Valor de salida
      nuContrato contrato asignar
      nuOk  almacena si hubo exito 0 o sino -1
      sbError almacena error del proceso

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
      13/04/2019   horbath     Se modifica creando el procedimiento PRVALIORDEN que se encargue de lo siguiente:
                                  Al momento de asignar una orden hija:
                                        - El presupuesto de las ordenes se tomaran de la tabla LDC_ORDENES_OFERTADOS_REDES filtrando por el
                                          campo orden hija (ORDEN_HIJA) y que el campo orden nieta este vacio (ORDEN_NIETA).
                                        - Si la OT no tiene presupuesto o tiene presupuesto en 0 en la forma LDCDEORREOF, el sistema no dejar?
                                          asignar. Notificar? al usuario un mensaje de error indicando que la orden a asignar no cuenta con
                                          presupuesto definido en LDCDEORREOF.
                                        - Si la OT cuenta con presupuesto asignado en la forma LDCDEORREOF, validar? el Cupo Disponible del
                                          contrato:
                                          * Si el contrato cuenta con cupo, es decir Cupo Disponible >= valor LDCDEORREOF permitir? asignar la
                                            orden de trabajo, asignar el valor en el campo Estimated_Cost de la orden, sumar al VALOR_ASIGNADO
                                            del Contrato el valor LDCDEORREOF. Se utilizar? el mismo servicio del caso 200-1138 para la actualizaci?n de costo
                                   estimado, valores del contrato (LDC_PKGASIGNARCONT.PROCVALACUMTTACT), que actualiza el estimated_cost y el valor_asignado.
                                          * Si el contrato no cuenta con cupo suficiente, no permitir? asignar la orden y notificar? al usuario que el contrato no
                                       cuenta con presupuesto suficiente para asignar la orden.


    ***************************************************************************/

 FUNCTION fblValiFechContLega( nuContrato IN ge_contrato.id_contrato%TYPE,
                               nuOk       OUT NUMBER,
                               sbError    OUT VARCHAR2) RETURN BOOLEAN;
  /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2017-04-07
      Ticket      : 200-810
      Descripcion : funcion para validar que la fecha final del contrato no sea menor a la fecha del sistema

      Parametros Entrada
      nuContrato numero del contrato

      Valor de salida
      nuOk  almacena si hubo exito 0 o sino -1
      sbError almacena error del proceso

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION

    ***************************************************************************/

PROCEDURE procvalacumttact(nupacostoprom ldc_taskactcostprom.costo_prom%TYPE,nupacostopromleg ldc_taskactcostprom.costo_prom%TYPE,nupacontrato
or_order.defined_contract_id%TYPE,nupanewestot or_order.order_id%TYPE,nupatipcausal ge_causal.class_causal_id%TYPE);

procedure PRVALIORDEN(nuorder or_order.order_id%type,nuestado or_order.order_status_id%type,
nuestadov or_order.order_status_id%type,
nucontrato ge_contrato.id_contrato%type,
nuoperating_unit_id or_order.operating_unit_id%type,
nuoperating_unit_idv or_order.operating_unit_id%type,
nuEstimated_Cost or_order.Estimated_Cost%type,
valor_asignar out or_order.Estimated_Cost%type,
nuerror out number,sberror out varchar2);

procedure PRPROCMIOAIOORD(nuorder or_order.order_id%type,
valorantes number,
valordespues number,
nuerror out number,sberror out varchar2);


FUNCTION proGetCostEstorden(inuorden in or_order.order_id%type) return or_order.Estimated_Cost%type;
FUNCTION proGetEstadoOrden(inuorden in or_order.order_id%type) return or_order.ORDER_STATUS_ID%type;

PROCEDURE proActuaCostoEsti(inuorden in or_order.order_id%type, inucosto number);

FUNCTION fnuGetConfTipoCont(nuTipoTrab IN or_order.task_type_id%TYPE) RETURN NUMBER;
FUNCTION fnuGetConfTicoCont(nuContrato IN number) RETURN NUMBER;

PROCEDURE PRLOGPRESCONT( orden NUMBER,
						  orden_padre number,
						  estado number,
						  unidad_operativa number,
						  contrato number,
						  valor_estimado NUMBER,
						  mensa_error VARCHAR2,
						  fecha_error DATE);
 /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2019-10-07
      Ticket      : 200-2391
      Descripcion : Procedimiento que realiza log de datafix de presupuesto

      Parametros Entrada
       orden   			orden de trabajo
       orden_padre 		orden padre
       estado 			estado de la orden
       unidad_operativa unidad operativa
       contrato         contrato
       valor_estimado   valor estimado
	   mensa_error      mensaje de error
	   fecha_error      fecha de error

	   HISTORIA DE MODIFICACIONES
         FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
END LDC_PKGASIGNARCONT;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_PKGASIGNARCONT IS

  CSBVERSION  CONSTANT VARCHAR2(100) := 'OSS_SEA_LJLB_200810_2';

  FUNCTION FSBVERSION
    RETURN VARCHAR2 IS
  BEGIN
        return CSBVERSION;
  END;

 FUNCTION fnuGetConfTipoCont(nuTipoTrab IN or_order.task_type_id%TYPE) RETURN NUMBER IS
   /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2019-16-08
      Ticket      : 200-2391
      Descripcion : Procedimiento que valida si existe contrato configurado en el parametro

      Parametros Entrada
      nuTipoTrab tipo de trabajo

      Valor de salida
      0 no existe, 1 si existe

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION

    ***************************************************************************/

  nuValiCont NUMBER;
  ptipocont  VARCHAR2(4000) := dald_parameter.fsbgetvalue_chain('LDC_CONTIPOCONT', null);
  nuExiste NUMBER := 0;

 BEGIN
    -- 200-2391
     IF ptipocont is not null THEN
         SELECT SUM(CANT)  INTO nuValiCont
		 from ( SELECT COUNT(1) CANT
			    FROM CT_TASKTYPE_CONTYPE ct, GE_CONTRATO c
			    WHERE ct.FLAG_TYPE IN ('C')
				  AND ct.TASK_TYPE_ID = nuTipoTrab
				  AND ct.CONTRACT_ID = c.ID_CONTRATO
				  AND c.STATUS = ct_boconstants.fsbGetOpenStatus
				  AND c.ID_TIPO_CONTRATO  IN (SELECT to_number(COLUMN_VALUE) FROM TABLE(ldc_boutilities.splitstrings(ptipocont, ',')))
			   UNION ALL
			   SELECT COUNT(1) CANT
			   FROM CT_TASKTYPE_CONTYPE ct, GE_CONTRATO c
			   WHERE ct.FLAG_TYPE IN ('T')
				  AND ct.TASK_TYPE_ID = nuTipoTrab
				  AND c.ID_TIPO_CONTRATO = ct.CONTRACT_TYPE_ID
				  AND c.STATUS = ct_boconstants.fsbGetOpenStatus
				  AND c.ID_TIPO_CONTRATO  IN (SELECT to_number(COLUMN_VALUE) FROM TABLE(ldc_boutilities.splitstrings(ptipocont, ',')))
				  AND not exists(select null from CT_TASKTYPE_CONTYPE ct2 where ct2.CONTRACT_ID =c.id_contrato and ct2.FLAG_TYPE IN ('C'))
		  );

     END IF;

	 IF nuValiCont > 0 OR ptipocont IS NULL THEN
	     nuExiste := 1;
	 END IF;

	RETURN nuExiste;
 EXCEPTION
   WHEN OTHERS THEN
     RETURN nuExiste;
 END fnuGetConfTipoCont;

 FUNCTION fnuGetConfTicoCont(nuContrato IN number) RETURN NUMBER IS
   /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2019-16-08
      Ticket      : 200-2391
      Descripcion : Procedimiento que valida si existe contrato configurado en el parametro

      Parametros Entrada
      nuContrato contrato

      Valor de salida
      0 no existe, 1 si existe

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION

    ***************************************************************************/
PRAGMA AUTONOMOUS_TRANSACTION;
  nuValiCont NUMBER;
  ptipocont  VARCHAR2(4000) := dald_parameter.fsbgetvalue_chain('LDC_CONTIPOCONT', null);
  nuExiste NUMBER := 0;

  CURSOR cuContrato IS
  select COUNT(1)
  from ge_contrato
  where id_contrato= nuContrato and
	  id_tipo_contrato in ( SELECT to_number(COLUMN_VALUE)
	                        FROM TABLE(ldc_boutilities.splitstrings(ptipocont, ',')));

 BEGIN
    -- 200-2391
    OPEN cuContrato;
	FETCH cuContrato INTO nuExiste;
	IF cuContrato%NOTFOUND AND ptipocont IS NULL THEN
	   nuExiste := 1;
	END IF;
	CLOSE cuContrato;

	RETURN nuExiste;
 EXCEPTION
   WHEN OTHERS THEN
     RETURN nuExiste;
 END fnuGetConfTicoCont;

  PROCEDURE proAsignarContratoMigr (nuOrden   IN or_order.order_id%TYPE,
									nuOrdenPadre  IN or_order.order_id%TYPE,
									nuEstadootPa	 IN or_order.order_status_id%TYPE,
									nuCausal      in ge_causal.causal_id%type,
									nuUnidad   IN or_order.OPERATING_UNIT_ID%TYPE,
									nuTipoTrab IN or_order.task_type_id%TYPE,
									nuActividad  IN ge_items.items_id%TYPE,
									dtfechaAsig  IN DATE,
									nuContrato OUT ge_contrato.id_contrato%TYPE,
									nuOk       OUT NUMBER,
									sbError    OUT VARCHAR2) IS
  /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2017-04-07
      Ticket      : 200-810
      Descripcion : Procedimiento que asigna contrato a orden

      Parametros Entrada
      nuOrden  numero de la orden
      nuUnidad  unidad operativa de la orden
      nuTipoTrab tipo de trabajo

      Valor de salida
      nuContrato contrato
      nuOk  almacena si hubo exito 0 o sino -1
      sbError almacena error del proceso

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
      2019-04-19   HORBATH     Se modifica para atender validaciones del caso 200-2391
    ***************************************************************************/
      --TICKET 2000-810 LJLB -- se consulta  contrato de la orden padre
      CURSOR cuObtContPadre IS
      WITH OrdenPadre AS (
            SELECT o.order_id orden
            FROM or_related_order o
            WHERE RELATED_ORDER_ID = nuOrden
            UNION
            SELECT b.order_id orden
            FROM OR_ORDER_ACTIVITY a, OR_ORDER_ACTIVITY b
            WHERE a.order_id = nuOrden AND a.ORIGIN_ACTIVITY_ID = b.ORDER_ACTIVITY_ID),
      Contrato AS (
            SELECT o.DEFINED_CONTRACT_ID contrato,
                   c.fecha_final
            FROM or_order o, OrdenPadre op, OR_OPERATING_UNIT u, OR_OPERATING_UNIT UD, CT_TASKTYPE_CONTYPE CT, GE_CONTRATO C
            WHERE o.order_id = op.orden                      AND
                  o.OPERATING_UNIT_ID = u.OPERATING_UNIT_ID  AND
                  ud.CONTRACTOR_ID = u.CONTRACTOR_ID         AND
                  ud.OPERATING_UNIT_ID = nuUnidad            AND
                  o.DEFINED_CONTRACT_ID = c.id_contrato      AND
                  CT.FLAG_TYPE IN ('T','C')                  AND
                  CT.TASK_TYPE_ID = nuTipoTrab               AND
                  (CT.CONTRACT_ID = C.ID_CONTRATO  OR
                  C.ID_TIPO_CONTRATO = CT.CONTRACT_TYPE_ID)  AND
                  C.STATUS = ct_boconstants.fsbGetOpenStatus
      )
      SELECT *
      FROM contrato;

    --TICKET 2000-810 LJLB --se consulta si el tipo de trabajo y actividad estan configurado para buscar orden padre
    CURSOR cuConfActTitr IS
    SELECT 'X'
    FROM LDC_TITRACOP ta
    WHERE
        ta.ITEMS_ID = nuActividad AND
        ta.TASK_TYPE_ID = nuTipoTrab;

     --TICKET 2000-810 LJLB -- se consultan contratos que esten asociado al tipo de trabajo de la orden
     CURSOR cuConsContTitr IS
      select id_contrato
      from (SELECT c.id_contrato, c.fecha_inicial
      FROM CT_TASKTYPE_CONTYPE ct, GE_CONTRATO c, LDC_CONTFEMA cf, OR_OPERATING_UNIT UD
      WHERE ct.FLAG_TYPE IN ('C')
        AND ud.CONTRACTOR_ID  = c.id_contratista
        AND ud.OPERATING_UNIT_ID = nuUnidad
        AND ct.TASK_TYPE_ID = nuTipoTrab
        AND ct.CONTRACT_ID = c.ID_CONTRATO
        AND c.STATUS = ct_boconstants.fsbGetOpenStatus
        AND c.id_contrato = cf.id_contrato
        AND dtfechaAsig BETWEEN c.fecha_inicial AND c.fecha_final
        AND cf.fecha_maxasig > dtfechaAsig
    union all
      SELECT c.id_contrato, c.fecha_inicial
      FROM CT_TASKTYPE_CONTYPE ct, GE_CONTRATO c, LDC_CONTFEMA cf, OR_OPERATING_UNIT UD
      WHERE ct.FLAG_TYPE IN ('T')
        AND ud.CONTRACTOR_ID  = c.id_contratista
        AND ud.OPERATING_UNIT_ID = nuUnidad
        AND ct.TASK_TYPE_ID = nuTipoTrab
        AND c.ID_TIPO_CONTRATO = ct.CONTRACT_TYPE_ID
        AND c.STATUS = ct_boconstants.fsbGetOpenStatus
        AND c.id_contrato = cf.id_contrato
        AND dtfechaAsig BETWEEN c.fecha_inicial AND c.fecha_final
        AND cf.fecha_maxasig > dtfechaAsig
    AND not exists(select null from ct_tasktype_contype ct2 where ct2.CONTRACT_ID=c.id_contrato and ct2.FLAG_TYPE IN ('C'))
      ORDER BY FECHA_INICIAL DESC
      );

     --TICKET 2000-810 LJLB -- se consultan cantidad contratos que esten asociado al tipo de trabajo de la orden
     CURSOR cuCantContTitr IS
      SELECT SUM(CANT)
    FROM
    (SELECT COUNT(1) CANT
      FROM CT_TASKTYPE_CONTYPE ct, GE_CONTRATO c, LDC_CONTFEMA cf, OR_OPERATING_UNIT UD
      WHERE ct.FLAG_TYPE IN ('C')
        AND ct.TASK_TYPE_ID = nuTipoTrab
        AND ud.CONTRACTOR_ID  = c.id_contratista
        AND ud.OPERATING_UNIT_ID = nuUnidad
        AND ct.CONTRACT_ID = c.ID_CONTRATO
        AND c.STATUS = ct_boconstants.fsbGetOpenStatus
        AND c.id_contrato = cf.id_contrato
    union all
    SELECT COUNT(1) CANT
      FROM CT_TASKTYPE_CONTYPE ct, GE_CONTRATO c, LDC_CONTFEMA cf, OR_OPERATING_UNIT UD
      WHERE ct.FLAG_TYPE IN ('T')
        AND ct.TASK_TYPE_ID = nuTipoTrab
        AND ud.CONTRACTOR_ID  = c.id_contratista
        AND ud.OPERATING_UNIT_ID = nuUnidad
        AND c.ID_TIPO_CONTRATO = ct.CONTRACT_TYPE_ID
        AND c.STATUS = ct_boconstants.fsbGetOpenStatus
        AND c.id_contrato = cf.id_contrato
    AND not exists(select null from CT_TASKTYPE_CONTYPE ct2 where ct2.CONTRACT_ID =c.id_contrato and ct2.FLAG_TYPE IN ('C')))
       ;

    nuCantCont NUMBER; --TICKET 2000-810 LJLB -- se asigna la cantidad de contrato asociado al tipo de trabajo
   -- nuContrato ge_contrato.id_contrato%TYPE; --TICKET 2000-810 LJLB -- se almacena contrato asignar
    dtFechFinalCont  ge_contrato.fecha_final%TYPE; --TICKET 2000-810 LJLB -- se almacena fecha final del contrato padre
    sdDato VARCHAR2(1); --TICKET 2000-810 LJLB -- se almacena dato de la configuracion de titr por actividad

    sbFlag  VARCHAR2(1) := 'N'; --TICKET 2000-810 LJLB -- se asigna valor de flag para saber si el titr esta configurado para buscar ordne padre

    erDatoInvalido EXCEPTION; --TICKET 2000-810 LJLB -- se almacena error del proceso

    np number;
    ptipocont ld_parameter.value_chain%type;
    valtipc   NUMBER;
    VALTIPCT  NUMBER;
    SW1 BOOLEAN;
    SW2 BOOLEAN;
    nucontrato1 ge_contrato.id_contrato%type;
	sbMesErr  varchar2(4000);
	rgOrdenPadre  daor_order.styOr_order;

  PROCEDURE PRVALICONTITRREAP(inuOrder IN OR_ORDER.ORDER_ID%TYPE,
                rgOtPadre IN daor_order.styOr_order,
                nuContrato OUT GE_CONTRATO.ID_CONTRATO%TYPE,
                sbError    OUT VARCHAR2) IS


    nuActiOrig OR_ORDER_ACTIVITY.activity_id%TYPE;
    nuActiDest OR_ORDER_ACTIVITY.activity_id%TYPE;
    nuTitrDest or_task_type.task_type_id%TYPE;
    nuUnidadDe or_operating_unit.operating_unit_id%type;
    nuNoValidaFecha number;
	nuContratoHija	or_order.defined_contract_id%type;
  BEGIN
    nuContrato:=0;

    IF rgOtPadre.order_id IS NOT NULL THEN -- ENCONTRO REGISTRO

      nuActiOrig:=daor_order_activity.fnugetactivity_id(ldc_bcfinanceot.fnugetactivityid(rgOtPadre.order_id),NULL); --DETERMINA ACTIVIDAD ORDEN ORIGEN
      nuActiDest:=nuActividad;
      nuTitrDest:=nuTipoTrab;
      nuUnidadDe:=nuUnidad;
      ut_trace.trace('PRVALICONTITRREAP=> nuUnidad' ||nuUnidad,10);
      ut_trace.trace('PRVALICONTITRREAP=> nuActiDest' ||nuActiDest,10);
      ut_trace.trace('PRVALICONTITRREAP=> nuTitrDest' ||nuTitrDest,10);
      ut_trace.trace('PRVALICONTITRREAP=> nuActiOrig' ||nuActiOrig,10);
      ut_trace.trace('PRVALICONTITRREAP=> rgOtPadre.operating_unit_id' ||rgOtPadre.operating_unit_id,10);
      ut_trace.trace('PRVALICONTITRREAP=> nuCausal' ||nuCausal,10);
      ut_trace.trace('PRVALICONTITRREAP=> rgOtPadre.causal_id' ||rgOtPadre.causal_id,10);


      if daor_operating_unit.fnugetcontractor_id(nuUnidad,null) = daor_operating_unit.fnugetcontractor_id(rgOtPadre.operating_unit_id,null) then

        IF nuEstadootPa=8 THEN --ORDEN ORIGEN ESTA LEGALIZADA
          SELECT COUNT(1)
          INTO nuNoValidaFecha
          FROM LDC_CONFTITRREGAPO
          WHERE TIPOTROR  = rgOtPadre.task_type_id AND
            ACTIVOR   = nuActiOrig AND
            CAUSLEG   = nvl(nuCausal,rgOtPadre.causal_id) AND
            tipotrde  = nuTitrDest AND
            ACTIVDE   = nuActiDest;

        ELSE
          SELECT COUNT(1)
          INTO nuNoValidaFecha
          FROM LDC_CONFTITRREGAPO
          WHERE TIPOTROR  = rgOtPadre.task_type_id AND
            ACTIVOR   = nuActiOrig AND
            CAUSLEG IS NULL AND
            tipotrde  = nuTitrDest AND
            ACTIVDE   = nuActiDest;
        END IF;

		begin
			select defined_contract_id into nuContratoHija
			  from or_order o
			 where order_id=inuOrder;
		exception
		when others then
			nuContratoHija :=-1;
		end;


        if rgOtPadre.defined_contract_id is not null then
			  if dage_contrato.fsbgetstatus(rgOtPadre.defined_contract_id,null) = ct_boconstants.fsbGetOpenStatus then
				IF  (CT_BCCONTRACTTASKTYPE.FBLHASTASKTYPESDEFINED( rgOtPadre.defined_contract_id,'C') AND ct_bccontracttasktype.fblhastasktype(rgOtPadre.defined_contract_id, nuTitrDest,'C') OR
					(NOT CT_BCCONTRACTTASKTYPE.FBLHASTASKTYPESDEFINED( rgOtPadre.defined_contract_id,'C') AND ct_bccontracttasktype.fblhastasktype(rgOtPadre.defined_contract_id, nuTitrDest,'T'))) then
				  IF nuNoValidaFecha > 0 THEN
					nuContrato:=rgOtPadre.defined_contract_id;
				  else
					if nuContratoHija = rgOtPadre.defined_contract_id then
						nuContrato:=rgOtPadre.defined_contract_id;
					else
						if daldc_contfema.fdtGetFECHA_MAXASIG(rgOtPadre.defined_contract_id, null) > dtfechaAsig then
						  if dage_contrato.fdtgetfecha_final(rgOtPadre.defined_contract_id, null) > dtfechaAsig then
							nuContrato:=rgOtPadre.defined_contract_id;
						  else
							sbError :='La fecha final del contrato padre ('||rgOtPadre.defined_contract_id||') esta vencida, favor validar.';
						  end if; --validar fecha final
						else
						  sbError :='La fecha maxima de asignacion del contrato padre ('||rgOtPadre.defined_contract_id||') esta vencida, favor validar.';
						end if;-- validar fecha maxima de asignacion
					end if;--if nuContratoHija = rgOtPadre.defined_contract_id then
				  end if;--validar si no se debe validaar fecha
				end if;--si el tipo de trabajo aplica al contrato de la orden padre
			  end if;--si el contrato padre esta abbierto

        end if;--si el contrato padre no es nulo
      end if; --si es el mismo contratista
    end if;-- si la orden padre no esta vacia
  EXCEPTION
    WHEN OTHERS THEN
      sbError := 'ERROR AL OBTENER CONTRATO PADRE: '||SQLERRM;
  END PRVALICONTITRREAP;

  BEGIN

    VALTIPC := fnuGetConfTipoCont(nuTipoTrab); --se valida configuracion de tipo de contrato


     IF (VALTIPC > 0 ) THEN
        SW1:=TRUE;
        --200-2391 PASA LA SIGUIENTE VALIDACION
        -- Si el par?metro LDC_CONTIPOCONT est? diligenciado y
        -- el Tipo de Trabajo de la Orden a asignar est? vinculado a un contrato abierto cuyo tipo de contrato NO est? configurado en el par?metro
        -- o el tipo de trabajo de la orden a asignar est? vinculado a un tipo de contrato que NO est? configurado en el par?metro
     ELSE
        SW1:=FALSE;
        --200-2391 NO PASA LA SIGUIENTE VALIDACION
        -- Si el par?metro LDC_CONTIPOCONT est? diligenciado y
        -- el Tipo de Trabajo de la Orden a asignar est? vinculado a un contrato abierto cuyo tipo de contrato NO est? configurado en el par?metro
        -- o el tipo de trabajo de la orden a asignar est? vinculado a un tipo de contrato que NO est? configurado en el par?metro

     END IF;

     IF SW1 THEN --200-2391 DEJA PASAR LAS VALIDACIONES

       --primero busco si le debo pegar el contrato padre
      if cuConfActTitr%isopen then
        close cuConfActTitr;
      end if;
      OPEN cuConfActTitr;
      FETCH cuConfActTitr INTO sdDato;
      IF cuConfActTitr%FOUND THEN
        sbMesErr:=null;
		if nuOrdenPadre is not null then
			daor_order.getrecord(nuOrdenPadre,rgOrdenPadre);
			PRVALICONTITRREAP(nuorden, rgOrdenPadre, nucontrato1, sbMesErr);
		end if;

        IF nucontrato1<>0 and nucontrato1<>-1 THEN
          nucontrato:=nucontrato1;
        else
          if sbMesErr is not null then
            sbError :=sbMesErr;
            RAISE erDatoInvalido;
          else
            sbFlag:='S';
          end if;
        end if;
      ELSE
        sbFlag := 'S';  --TICKET 2000-810 LJLB -- se indica que no hay configuracion de tipo de trabajo y actividad para buscar orden padre
      End if;
      CLOSE cuConfActTitr;


        --TICKET 2000-810 LJLB -- se valida si el proceso de orden padre termino sin exito
       IF  sbFlag = 'S' THEN
        --TICKET 2000-810 LJLB -- se valida si hay contrato que cumplan con las condiciones
         OPEN cuConsContTitr;
         FETCH cuConsContTitr INTO nuContrato;
         IF cuConsContTitr%NOTFOUND THEN
          sbError := 'No existen Contrato en estado Abierto que su fecha maxima de asignacion sea mayor a la del sistema o que tenga configurado el tipo de trabajo ['||nuTipoTrab||']';
          CLOSE cuConsContTitr;
          RAISE erDatoInvalido;
         END IF;
         CLOSE cuConsContTitr;
       END IF;
       if nuContrato is null then
        sbError :='No se determino contrato en la asignaci??e la orden.';
        RAISE erDatoInvalido;
       end if;
    end if;--SW1=TRUE
    nuOk := 0;
  EXCEPTION
    When ex.controlled_error Then
         nuok := -1;
         sberror:='Error controlado en ldc_pkgasignarcont.proAsignarContrato.'||sqlerrm;
         Raise;

    WHEN erDatoInvalido THEN
         nuok := -1;
    WHEN OTHERS THEN
        nuOk := -1;
        sbError := 'Error no controlado en ldc_pkgasignarcont.proAsignarContrato '||sqlerrm;
  END proAsignarContratoMigr;

 PROCEDURE proAsignarContrato (nuOrden   IN or_order.order_id%TYPE,
                               nuOrdenPadre  IN or_order.order_id%TYPE,
							                 nuEstadootPa	 IN or_order.order_status_id%TYPE,
                               nuCausal      in ge_causal.causal_id%type,
                               nuUnidad   IN or_order.OPERATING_UNIT_ID%TYPE,
                               nuTipoTrab IN or_order.task_type_id%TYPE,
                               nuActividad  IN ge_items.items_id%TYPE,
                               nuContrato OUT ge_contrato.id_contrato%TYPE,
                               nuOk       OUT NUMBER,
                               sbError    OUT VARCHAR2) IS
  /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2017-04-07
      Ticket      : 200-810
      Descripcion : Procedimiento que asigna contrato a orden

      Parametros Entrada
      nuOrden  numero de la orden
      nuUnidad  unidad operativa de la orden
      nuTipoTrab tipo de trabajo

      Valor de salida
      nuContrato contrato
      nuOk  almacena si hubo exito 0 o sino -1
      sbError almacena error del proceso

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
      2019-04-19   HORBATH     Se modifica para atender validaciones del caso 200-2391
    ***************************************************************************/
      --TICKET 2000-810 LJLB -- se consulta  contrato de la orden padre
      CURSOR cuObtContPadre IS
      WITH OrdenPadre AS (
            SELECT o.order_id orden
            FROM or_related_order o
            WHERE RELATED_ORDER_ID = nuOrden
            UNION
            SELECT b.order_id orden
            FROM OR_ORDER_ACTIVITY a, OR_ORDER_ACTIVITY b
            WHERE a.order_id = nuOrden AND a.ORIGIN_ACTIVITY_ID = b.ORDER_ACTIVITY_ID),
      Contrato AS (
            SELECT o.DEFINED_CONTRACT_ID contrato,
                   c.fecha_final
            FROM or_order o, OrdenPadre op, OR_OPERATING_UNIT u, OR_OPERATING_UNIT UD, CT_TASKTYPE_CONTYPE CT, GE_CONTRATO C
            WHERE o.order_id = op.orden                      AND
                  o.OPERATING_UNIT_ID = u.OPERATING_UNIT_ID  AND
                  ud.CONTRACTOR_ID = u.CONTRACTOR_ID         AND
                  ud.OPERATING_UNIT_ID = nuUnidad            AND
                  o.DEFINED_CONTRACT_ID = c.id_contrato      AND
                  CT.FLAG_TYPE IN ('T','C')                  AND
                  CT.TASK_TYPE_ID = nuTipoTrab               AND
                  (CT.CONTRACT_ID = C.ID_CONTRATO  OR
                  C.ID_TIPO_CONTRATO = CT.CONTRACT_TYPE_ID)  AND
                  C.STATUS = ct_boconstants.fsbGetOpenStatus
      )
      SELECT *
      FROM contrato;

    --TICKET 2000-810 LJLB --se consulta si el tipo de trabajo y actividad estan configurado para buscar orden padre
    CURSOR cuConfActTitr IS
    SELECT 'X'
    FROM LDC_TITRACOP ta
    WHERE
        ta.ITEMS_ID = nuActividad AND
        ta.TASK_TYPE_ID = nuTipoTrab;

     --TICKET 2000-810 LJLB -- se consultan contratos que esten asociado al tipo de trabajo de la orden
     CURSOR cuConsContTitr IS
      select id_contrato
      from (SELECT c.id_contrato, c.fecha_inicial
      FROM CT_TASKTYPE_CONTYPE ct, GE_CONTRATO c, LDC_CONTFEMA cf, OR_OPERATING_UNIT UD
      WHERE ct.FLAG_TYPE IN ('C')
        AND ud.CONTRACTOR_ID  = c.id_contratista
        AND ud.OPERATING_UNIT_ID = nuUnidad
        AND ct.TASK_TYPE_ID = nuTipoTrab
        AND ct.CONTRACT_ID = c.ID_CONTRATO
        AND c.STATUS = ct_boconstants.fsbGetOpenStatus
        AND c.id_contrato = cf.id_contrato
        AND SYSDATE BETWEEN c.fecha_inicial AND c.fecha_final
        AND cf.fecha_maxasig > SYSDATE
    union all
      SELECT c.id_contrato, c.fecha_inicial
      FROM CT_TASKTYPE_CONTYPE ct, GE_CONTRATO c, LDC_CONTFEMA cf, OR_OPERATING_UNIT UD
      WHERE ct.FLAG_TYPE IN ('T')
        AND ud.CONTRACTOR_ID  = c.id_contratista
        AND ud.OPERATING_UNIT_ID = nuUnidad
        AND ct.TASK_TYPE_ID = nuTipoTrab
        AND c.ID_TIPO_CONTRATO = ct.CONTRACT_TYPE_ID
        AND c.STATUS = ct_boconstants.fsbGetOpenStatus
        AND c.id_contrato = cf.id_contrato
        AND SYSDATE BETWEEN c.fecha_inicial AND c.fecha_final
        AND cf.fecha_maxasig > SYSDATE
    AND not exists(select null from ct_tasktype_contype ct2 where ct2.CONTRACT_ID=c.id_contrato and ct2.FLAG_TYPE IN ('C'))
      ORDER BY FECHA_INICIAL DESC
      );

     --TICKET 2000-810 LJLB -- se consultan cantidad contratos que esten asociado al tipo de trabajo de la orden
     CURSOR cuCantContTitr IS
      SELECT SUM(CANT)
    FROM
    (SELECT COUNT(1) CANT
      FROM CT_TASKTYPE_CONTYPE ct, GE_CONTRATO c, LDC_CONTFEMA cf, OR_OPERATING_UNIT UD
      WHERE ct.FLAG_TYPE IN ('C')
        AND ct.TASK_TYPE_ID = nuTipoTrab
        AND ud.CONTRACTOR_ID  = c.id_contratista
        AND ud.OPERATING_UNIT_ID = nuUnidad
        AND ct.CONTRACT_ID = c.ID_CONTRATO
        AND c.STATUS = ct_boconstants.fsbGetOpenStatus
        AND c.id_contrato = cf.id_contrato
    union all
    SELECT COUNT(1) CANT
      FROM CT_TASKTYPE_CONTYPE ct, GE_CONTRATO c, LDC_CONTFEMA cf, OR_OPERATING_UNIT UD
      WHERE ct.FLAG_TYPE IN ('T')
        AND ct.TASK_TYPE_ID = nuTipoTrab
        AND ud.CONTRACTOR_ID  = c.id_contratista
        AND ud.OPERATING_UNIT_ID = nuUnidad
        AND c.ID_TIPO_CONTRATO = ct.CONTRACT_TYPE_ID
        AND c.STATUS = ct_boconstants.fsbGetOpenStatus
        AND c.id_contrato = cf.id_contrato
    AND not exists(select null from CT_TASKTYPE_CONTYPE ct2 where ct2.CONTRACT_ID =c.id_contrato and ct2.FLAG_TYPE IN ('C')))
       ;

    nuCantCont NUMBER; --TICKET 2000-810 LJLB -- se asigna la cantidad de contrato asociado al tipo de trabajo
   -- nuContrato ge_contrato.id_contrato%TYPE; --TICKET 2000-810 LJLB -- se almacena contrato asignar
    dtFechFinalCont  ge_contrato.fecha_final%TYPE; --TICKET 2000-810 LJLB -- se almacena fecha final del contrato padre
    sdDato VARCHAR2(1); --TICKET 2000-810 LJLB -- se almacena dato de la configuracion de titr por actividad

    sbFlag  VARCHAR2(1) := 'N'; --TICKET 2000-810 LJLB -- se asigna valor de flag para saber si el titr esta configurado para buscar ordne padre

    erDatoInvalido EXCEPTION; --TICKET 2000-810 LJLB -- se almacena error del proceso

    PRAGMA AUTONOMOUS_TRANSACTION;
    np number;
    ptipocont ld_parameter.value_chain%type;
    valtipc   NUMBER;
    VALTIPCT  NUMBER;
    SW1 BOOLEAN;
    SW2 BOOLEAN;
    nucontrato1 ge_contrato.id_contrato%type;
	sbMesErr  varchar2(4000);
	rgOrdenPadre  daor_order.styOr_order;

  PROCEDURE PRVALICONTITRREAP(inuOrder IN OR_ORDER.ORDER_ID%TYPE,
                rgOtPadre IN daor_order.styOr_order,
                nuContrato OUT GE_CONTRATO.ID_CONTRATO%TYPE,
                sbError    OUT VARCHAR2) IS


    nuActiOrig OR_ORDER_ACTIVITY.activity_id%TYPE;
    nuActiDest OR_ORDER_ACTIVITY.activity_id%TYPE;
    nuTitrDest or_task_type.task_type_id%TYPE;
    nuUnidadDe or_operating_unit.operating_unit_id%type;
    nuNoValidaFecha number;
	nuContratoHija	or_order.defined_contract_id%type;
  BEGIN
    nuContrato:=0;

    IF rgOtPadre.order_id IS NOT NULL THEN -- ENCONTRO REGISTRO

      nuActiOrig:=daor_order_activity.fnugetactivity_id(ldc_bcfinanceot.fnugetactivityid(rgOtPadre.order_id),NULL); --DETERMINA ACTIVIDAD ORDEN ORIGEN
      nuActiDest:=nuActividad;
      nuTitrDest:=nuTipoTrab;
      nuUnidadDe:=nuUnidad;
      ut_trace.trace('PRVALICONTITRREAP=> nuUnidad' ||nuUnidad,10);
      ut_trace.trace('PRVALICONTITRREAP=> nuActiDest' ||nuActiDest,10);
      ut_trace.trace('PRVALICONTITRREAP=> nuTitrDest' ||nuTitrDest,10);
      ut_trace.trace('PRVALICONTITRREAP=> nuActiOrig' ||nuActiOrig,10);
      ut_trace.trace('PRVALICONTITRREAP=> rgOtPadre.operating_unit_id' ||rgOtPadre.operating_unit_id,10);
      ut_trace.trace('PRVALICONTITRREAP=> nuCausal' ||nuCausal,10);
      ut_trace.trace('PRVALICONTITRREAP=> rgOtPadre.causal_id' ||rgOtPadre.causal_id,10);


      if daor_operating_unit.fnugetcontractor_id(nuUnidad,null) = daor_operating_unit.fnugetcontractor_id(rgOtPadre.operating_unit_id,null) then

        IF nuEstadootPa=8 THEN --ORDEN ORIGEN ESTA LEGALIZADA
          SELECT COUNT(1)
          INTO nuNoValidaFecha
          FROM LDC_CONFTITRREGAPO
          WHERE TIPOTROR  = rgOtPadre.task_type_id AND
            ACTIVOR   = nuActiOrig AND
            CAUSLEG   = nvl(nuCausal,rgOtPadre.causal_id) AND
            tipotrde  = nuTitrDest AND
            ACTIVDE   = nuActiDest;

        ELSE
          SELECT COUNT(1)
          INTO nuNoValidaFecha
          FROM LDC_CONFTITRREGAPO
          WHERE TIPOTROR  = rgOtPadre.task_type_id AND
            ACTIVOR   = nuActiOrig AND
            CAUSLEG IS NULL AND
            tipotrde  = nuTitrDest AND
            ACTIVDE   = nuActiDest;
        END IF;

		begin
			select defined_contract_id into nuContratoHija
			  from or_order o
			 where order_id=inuOrder;
		exception
		when others then
			nuContratoHija :=-1;
		end;


        if rgOtPadre.defined_contract_id is not null then
			  if dage_contrato.fsbgetstatus(rgOtPadre.defined_contract_id,null) = ct_boconstants.fsbGetOpenStatus then
				IF  (CT_BCCONTRACTTASKTYPE.FBLHASTASKTYPESDEFINED( rgOtPadre.defined_contract_id,'C') AND ct_bccontracttasktype.fblhastasktype(rgOtPadre.defined_contract_id, nuTitrDest,'C') OR
					(NOT CT_BCCONTRACTTASKTYPE.FBLHASTASKTYPESDEFINED( rgOtPadre.defined_contract_id,'C') AND ct_bccontracttasktype.fblhastasktype(rgOtPadre.defined_contract_id, nuTitrDest,'T'))) then
				  IF nuNoValidaFecha > 0 THEN
					nuContrato:=rgOtPadre.defined_contract_id;
				  else
					if nuContratoHija = rgOtPadre.defined_contract_id then
						nuContrato:=rgOtPadre.defined_contract_id;
					else
						if daldc_contfema.fdtGetFECHA_MAXASIG(rgOtPadre.defined_contract_id, null) > sysdate then
						  if dage_contrato.fdtgetfecha_final(rgOtPadre.defined_contract_id, null) > sysdate then
							nuContrato:=rgOtPadre.defined_contract_id;
						  else
							sbError :='La fecha final del contrato padre ('||rgOtPadre.defined_contract_id||') esta vencida, favor validar.';
						  end if; --validar fecha final
						else
						  sbError :='La fecha maxima de asignaci??el contrato padre ('||rgOtPadre.defined_contract_id||') esta vencida, favor validar.';
						end if;-- validar fecha maxima de asignacion
					end if;--if nuContratoHija = rgOtPadre.defined_contract_id then
				  end if;--validar si no se debe validaar fecha
				end if;--si el tipo de trabajo aplica al contrato de la orden padre
			  end if;--si el contrato padre esta abbierto

        end if;--si el contrato padre no es nulo
      end if; --si es el mismo contratista
    end if;-- si la orden padre no esta vacia
  EXCEPTION
    WHEN OTHERS THEN
      sbError := 'ERROR AL OBTENER CONTRATO PADRE: '||SQLERRM;
  END PRVALICONTITRREAP;

  BEGIN

    VALTIPC := fnuGetConfTipoCont(nuTipoTrab); --se valida configuracion de tipo de contrato


     IF (VALTIPC > 0 ) THEN
        SW1:=TRUE;
        --200-2391 PASA LA SIGUIENTE VALIDACION
        -- Si el par?metro LDC_CONTIPOCONT est? diligenciado y
        -- el Tipo de Trabajo de la Orden a asignar est? vinculado a un contrato abierto cuyo tipo de contrato NO est? configurado en el par?metro
        -- o el tipo de trabajo de la orden a asignar est? vinculado a un tipo de contrato que NO est? configurado en el par?metro
     ELSE
        SW1:=FALSE;
        --200-2391 NO PASA LA SIGUIENTE VALIDACION
        -- Si el par?metro LDC_CONTIPOCONT est? diligenciado y
        -- el Tipo de Trabajo de la Orden a asignar est? vinculado a un contrato abierto cuyo tipo de contrato NO est? configurado en el par?metro
        -- o el tipo de trabajo de la orden a asignar est? vinculado a un tipo de contrato que NO est? configurado en el par?metro

     END IF;

     IF SW1 THEN --200-2391 DEJA PASAR LAS VALIDACIONES

       --primero busco si le debo pegar el contrato padre
      if cuConfActTitr%isopen then
        close cuConfActTitr;
      end if;
      OPEN cuConfActTitr;
      FETCH cuConfActTitr INTO sdDato;
      IF cuConfActTitr%FOUND THEN
        sbMesErr:=null;
		if nuOrdenPadre is not null then
			daor_order.getrecord(nuOrdenPadre,rgOrdenPadre);
			PRVALICONTITRREAP(nuorden, rgOrdenPadre, nucontrato1, sbMesErr);
		end if;

        IF nucontrato1<>0 and nucontrato1<>-1 THEN
          nucontrato:=nucontrato1;
        else
          if sbMesErr is not null then
            sbError :=sbMesErr;
            RAISE erDatoInvalido;
          else
            sbFlag:='S';
          end if;
        end if;
      ELSE
        sbFlag := 'S';  --TICKET 2000-810 LJLB -- se indica que no hay configuracion de tipo de trabajo y actividad para buscar orden padre
      End if;
      CLOSE cuConfActTitr;


        --TICKET 2000-810 LJLB -- se valida si el proceso de orden padre termino sin exito
       IF  sbFlag = 'S' THEN
        --TICKET 2000-810 LJLB -- se valida si hay contrato que cumplan con las condiciones
         OPEN cuConsContTitr;
         FETCH cuConsContTitr INTO nuContrato;
         IF cuConsContTitr%NOTFOUND THEN
          sbError := 'No existen Contrato en estado Abierto que su fecha maxima de asignacion sea mayor a la del sistema o que tenga configurado el tipo de trabajo ['||nuTipoTrab||']';
          CLOSE cuConsContTitr;
          RAISE erDatoInvalido;
         END IF;
         CLOSE cuConsContTitr;
       END IF;
       if nuContrato is null then
        sbError :='No se determino contrato en la asignacion la orden.';
        RAISE erDatoInvalido;
       end if;
    end if;--SW1=TRUE
    nuOk := 0;
  EXCEPTION
    When ex.controlled_error Then
         nuok := -1;
         sberror:='Error controlado en ldc_pkgasignarcont.proAsignarContrato.'||sqlerrm;
         Raise;

    WHEN erDatoInvalido THEN
         nuok := -1;
    WHEN OTHERS THEN
        nuOk := -1;
        sbError := 'Error no controlado en ldc_pkgasignarcont.proAsignarContrato '||sqlerrm;
  END proAsignarContrato;


 FUNCTION fblValiFechContLega( nuContrato IN ge_contrato.id_contrato%TYPE,
                               nuOk       OUT NUMBER,
                               sbError    OUT VARCHAR2) RETURN BOOLEAN IS
  /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2017-04-07
      Ticket      : 200-810
      Descripcion : funcion para validar que la fecha final del contrato no sea menor a la fecha del sistema

      Parametros Entrada
      nuContrato numero del contrato

      Valor de salida
      nuOk  almacena si hubo exito 0 o sino -1
      sbError almacena error del proceso

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION

    ***************************************************************************/

   dtFinalDate ge_contrato.fecha_final%TYPE; --TICKET 2000-810 LJLB -- se almacena fecha final del contrato

 BEGIN
    dtFinalDate  := dage_contrato.fdtGetFecha_Final(nuContrato,0); --TICKET 2000-810 LJLB -- se consulta fecha final del contrato
    --TICKET 2000-810 LJLB -- se valida que la fecha final no sea menor a la fecha del sistema
    IF dtFinalDate < SYSDATE THEN
       sbError := 'Fecha final ['||dtFinalDate||'] del contrato ['||nuContrato||'], es menor a la fecha del sistema';
       nuOk := -1;
       RETURN FALSE;
    END IF;
    nuOk := 0;
   RETURN TRUE;
 EXCEPTION
    WHEN OTHERS THEN
        nuOk := -1;
        sbError := 'Error no controlado en ldc_pkgasignarcont.fblValiFechContLega '||sqlerrm;
        RETURN FALSE;
 END fblValiFechContLega;
PROCEDURE procvalacumttact(nupacostoprom ldc_taskactcostprom.costo_prom%TYPE,nupacostopromleg ldc_taskactcostprom.costo_prom%TYPE,nupacontrato
or_order.defined_contract_id%TYPE,nupanewestot or_order.order_id%TYPE,nupatipcausal ge_causal.class_causal_id%TYPE) IS
 sbmensaje         VARCHAR2(1000);
 eerror            EXCEPTION;
 sbestadoAsigEje    VARCHAR2(4000) := DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_ESTAPRDECONT', NULL);
BEGIN
 IF INSTR(sbestadoAsigEje,nupanewestot) > 0 THEN
  UPDATE ge_contrato con
     SET con.valor_asignado = nvl(con.valor_asignado,0) + nvl(nupacostoprom,0)
   WHERE con.id_contrato = nupacontrato;
 ELSIF nupanewestot IN(0,11,12,8) THEN
  UPDATE ge_contrato con
     SET con.valor_asignado = nvl(con.valor_asignado,0) - nvl(nupacostoprom,0)
   WHERE con.id_contrato    = nupacontrato;
   IF nupanewestot = 8 AND nupatipcausal = 1 THEN
    UPDATE ge_contrato con
       SET con.valor_no_liquidado = nvl(con.valor_no_liquidado,0) + nvl(nupacostopromleg,0)
     WHERE con.id_contrato    = nupacontrato;
   END IF;
 END IF;
EXCEPTION
 WHEN eerror THEN
  ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensaje);
 WHEN OTHERS THEN
  sbmensaje := SQLERRM;
  ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,sbmensaje);
END procvalacumttact;

procedure PRVALIORDEN(  nuorder or_order.order_id%type,
                        nuestado or_order.order_status_id%type,
                        nuestadov or_order.order_status_id%type,
                        nucontrato ge_contrato.id_contrato%type,
                        nuoperating_unit_id or_order.operating_unit_id%type,
                        nuoperating_unit_idv or_order.operating_unit_id%type,
                        nuEstimated_Cost or_order.Estimated_Cost%type,
                        valor_asignar out or_order.Estimated_Cost%type,
                        nuerror out number,sberror out varchar2) is
  /**************************************************************************
      Autor       : Horbath
      Fecha       : 2019-04-13
      Ticket      : 200-2391
      Descripcion : procedimiento para validar consideraciones del caso 200-2391
      Parametros Entrada
      nuContrato numero del contrato

      Valor de salida
      nuOk  almacena si hubo exito 0 o sino -1
      sbError almacena error del proceso

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
      12/03/2020  DSALTARIN    357: Se modifica para que la reasignación tome el valor del presupuesto

    ***************************************************************************/

   PRAGMA AUTONOMOUS_TRANSACTION;

  oni   ldc_ordenes_ofertados_redes.orden_nieta%type;
  probr ldc_ordenes_ofertados_redes.presupuesto_obra%type;
  vasig number;
  cupo_disponible number;

  nuestadoejecutado    or_order.order_status_id%Type;
  nuestadolegalizado   or_order.order_status_id%Type;
  nuestadoasignado     or_order.order_status_id%Type;
  nuestadobloqueado    or_order.order_status_id%Type;
  sbClasifItem         VARCHAR2(4000) :=  DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_CLASITEMAEXCLUIR', NULL);
  ValorNietas          number;
  nucontractor_id  or_operating_unit.contractor_id%type;
  nucontractor_idv or_operating_unit.contractor_id%type;

 --Se calcula cupo disponible
 cursor cuCupoDispocont IS
 select nvl(VALOR_TOTAL_CONTRATO,0) - (nvl(valor_asignado,0) + nvl(valor_no_liquidado,0) + nvl(valor_liquidado,0)) cupodis
 from ge_contrato
 where ID_CONTRATO=nucontrato;

 --se consulta presupuesto de obra
 cursor cuPresObra IS
 select presupuesto_obra,orden_nieta --into probr,oni
 from ldc_ordenes_ofertados_redes
 where orden_hija=nuorder and orden_nieta is null;


begin
     nuerror:=0;
     sberror:='Sin error';
     vASIG:=0;
     nuestadoasignado := dald_parameter.fnugetnumeric_value('COD_ESTADO_ASIGNADA_OT',
                                                           Null);
     NUESTADOBLOQUEADO := dald_parameter.fnugetnumeric_value('COD_ESTA_BLOQ',
                                                           Null);
     open cuCupoDispocont;
   fetch cuCupoDispocont into cupo_disponible;
   close cuCupoDispocont;

   OPEN cuPresObra;
   FETCH cuPresObra INTO probr,oni;
   CLOSE cuPresObra;

    ut_trace.trace('Datos de Inicio Contrato: '||nucontrato||' cupo disponible: '||cupo_disponible||' presupuesto: '||probr||' estado nuevo '||nuestado||' estado anterior '||nuestadov, 10);
   if nuestado=nuestadoasignado and nuestadov=0 then -- validaciones cuando se asigna
        ut_trace.trace('Ingreso a asignar orden redes ',10);
      if nvl(probr,0)=0 then
        nuerror := 1;
        sberror := 'La orden a asignar no cuenta con presupuesto definido en LDCDEORREOF';
      else
        if cupo_disponible >= probr then
          vasig:=probr;
        else
          vasig:=0;
          nuerror:=1;
          sberror := 'No se puede asignar la orden porque el contrato['|| nucontrato||'] no tiene cupo disponible';
         end if;
      end if;
  end if;

     if nuestado=nuestadoasignado and nuestadov=nuestadoasignado then --validaciones a reasignar
        ut_trace.trace('Ingreso a Reasignar orden redes ',10);
         if nvl(probr,0)=0 then
             nuerror := 1;
             sberror := 'La orden a reasignar no cuenta con presupuesto definido en LDCDEORREOF';
        else
          select contractor_id into nucontractor_id from or_operating_unit where OPERATING_UNIT_ID=nuoperating_unit_id;
        select contractor_id into nucontractor_idv from or_operating_unit where OPERATING_UNIT_ID=nuoperating_unit_idv;
            if nucontractor_id=nucontractor_idv then
               null; -- permite seguir
            else
              if cupo_disponible >= probr  then
               vasig:=probr;
              else
                  nuerror := 1;
               sberror := 'No se puede asignar la orden porque el contrato['|| nucontrato||'] no tiene cupo disponible';
              end if;
            end if;
        end if;
     end if;

     -- 200-2391 desbloqueando orden
     if (nuestado=5) and nuestadov=nuestadobloqueado then
           ut_trace.trace('Ingreso a desbloqueo orden redes ',10);
       if nvl(probr,0)=0 then
         nuerror := 1;
        sberror := 'La orden a desbloquear no cuenta con presupuesto definido en LDCDEORREOF';
      else
         if cupo_disponible < nvl(probr,0) then
          vasig:=0;
          nuerror:=1;
          sberror := 'No se puede asignar la orden porque el contrato['|| nucontrato||'] no tiene cupo disponible';
         end if;
         if cupo_disponible >= nvl(probr,0) then
          -- calcula valor legalizado de ordenes hijas
          SELECT NVL(SUM(nvl(it.value,0)),0)
            INTO ValorNietas
            FROM or_order_items it,ge_items id,OR_ORDER ORD, LDC_ORDENES_OFERTADOS_REDES o
            WHERE o.ORDEN_HIJA = nuOrder
              AND o.ORDEN_NIETA = it.order_id
              AND ord.order_id = it.order_id
              And ord.order_status_id = 8
              AND id.item_classif_id not in  (SELECT to_number(COLUMN_VALUE) FROM TABLE(ldc_boutilities.splitstrings(sbClasifItem, ',') ))
              AND it.items_id = id.items_id;

          if cupo_disponible >= nvl(probr,0) - valornietas then
           vasig:=nvl(probr,0) - valornietas;
          else
           nuerror:=1;
           sberror := 'No se puede asignar la orden porque el contrato['|| nucontrato||'] no tiene cupo disponible';
          end if;
         end if;
      end if;
     end if;
     VALOR_ASIGNAR:=Vasig;
EXCEPTION
  WHEN OTHERS THEN
     nuerror:=1;
   sberror := 'Error no controlado en PRVALIORDEN '||sqlerrm;

end PRVALIORDEN;

procedure PRPROCMIOAIOORD(nuorder or_order.order_id%type,
valorantes number,
valordespues number,
nuerror out number,sberror out varchar2) is
  /**************************************************************************
      Autor       : Horbath
      Fecha       : 2019-04-16
      Ticket      : 200-2391
      Descripcion : procedimiento para validar consideraciones del caso 200-2391 al momento de modificar ordenes
      Parametros Entrada
      nuContrato numero del contrato

      Valor de salida
      nuOk  almacena si hubo exito 0 o sino -1
      sbError almacena error del proceso

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
      2019-04-16   horbath     creacion 200-2391
    ***************************************************************************/
	ptipocont ld_parameter.value_chain%type;
	vtipoc    varchar2(1); -- si el tipo contrato esta dentro del parametro LDC_CONTIPOCONT
	idcont ge_contrato.id_contrato%type;
	tipotr or_order.task_type_id%type;
	sbtitrredes       ld_parameter.VALUE_CHAIN%type :=dald_parameter.fsbgetvalue_chain('LDC_TITRVALREDES',NULL);
	tred varchar2(1) :='0'; -- si el tipo de trabajo de la orden es de redes
	oni number;
	n number;
	VALOR_TOTAL_CONTRATO ge_contrato.VALOR_TOTAL_CONTRATO%type;
	valor_asignado       ge_contrato.valor_asignado%type;
	valor_no_liquidado   ge_contrato.valor_no_liquidado%type;
	valor_liquidado      ge_contrato.valor_liquidado%type;
	cupo_disponible      number;
	oh LDC_ORDENES_OFERTADOS_REDES.orden_hija%type;
	eoh  or_order.order_status_id%type; -- estado orden hija
	ecoh or_order.estimated_cost%type;  -- estimated_cost de orden hija
	diferencia number;

	CURSOR cuGetOrdenPadre IS
	SELECT order_id
    FROM OR_RELATED_ORDER
    WHERE RELATED_ORDER_ID = nuorder ;

	nuOtPadre or_order.order_id%type;
	nuExistConf NUMBER;

begin
      ut_trace.trace('Ingreso a   PRPROCMIOAIOORD datos inicial: orden '||nuorder||' valor antes: '||valorantes||' valor despues '||valordespues,10);
   nuerror:=0;
     sberror:='Sin error';
     select count(1) into n
            from ld_parameter
            where parameter_id='LDC_CONTIPOCONT'; -- valida si se ha creado el parametro LDC_CONTIPOCONT;
     select DEFINED_CONTRACT_ID,task_type_id into idcont,tipotr
            from or_order where order_id=nuorder;

    nuExistConf := fnuGetConfTicoCont(idcont);

/*   if n=0 then
        nuerror:=1;
        sberror := 'No se ha creado el parametro LDC_CONTIPOCONT';
     else
        select value_chain into ptipocont
        from ld_parameter
		where parameter_id='LDC_CONTIPOCONT';
        vtipoc:='0';
        if ptipocont is not null and idcont is not null then -- valida que el tipo de contrato de la orden este dentro del parametro
           begin
                select '1' into vtipoc
                       from ge_contrato
                       where id_contrato=idcont and
                             id_tipo_contrato in (SELECT to_number(COLUMN_VALUE) FROM TABLE(ldc_boutilities.splitstrings(ptipocont, ',')));
           exception
                when no_data_found then
                     vtipoc:='0';
           end;
        end if;*/

	--	if (ptipocont is null or vtipoc='1') and idcont is not null then -- hace validaciones
	   IF nuExistConf > 0 THEN
			open cuGetOrdenPadre;
			fetch cuGetOrdenPadre into nuOtPadre;
			close cuGetOrdenPadre;
			begin
				select '1' into tred from dual where daor_order.fnugettask_type_id(nuOtPadre, null) in (SELECT TO_NUMBER(COLUMN_VALUE) FROM TABLE(LDC_BOUTILITIES.SPLITSTRINGS(sbtitrredes, ',')));
			exception
			when others then
				null;
			end;


		  diferencia :=  nvl(valordespues,0) - nvl(valorantes,0) ;
		  if tred='0'  then -- el tt de la orden no esta dentro de los tt de redes y el tipo contrato esta en el parametro LDC_CONTIPOCONT
		   if diferencia < 0 then -- disminuye valor legalizado
			  ut_trace.trace('Orden Normal disminuye '||diferencia,10);

			update or_order
			  set estimated_cost=nvl(estimated_cost,0) + diferencia
			  where order_id=nuorder;
		   else -- aumenta valor legalizado
			  ut_trace.trace('Orden Normal aumenta '||diferencia,10);
			-- valida si el contrato tiene cupo
			select VALOR_TOTAL_CONTRATO,valor_asignado,valor_no_liquidado,valor_liquidado
				 into VALOR_TOTAL_CONTRATO,valor_asignado,valor_no_liquidado,valor_liquidado
				 from ge_contrato
				 where ID_CONTRATO=idcont;
			-- 200-2391 calcula cupo disponible del contrato
			cupo_disponible:=nvl(VALOR_TOTAL_CONTRATO,0) - (nvl(valor_asignado,0) + nvl(valor_no_liquidado,0) + nvl(valor_liquidado,0) + diferencia);
			--if cupo_disponible > 0 then
				 update or_order
				set estimated_cost=nvl(estimated_cost,0)+ diferencia
			   where order_id=nuorder;
        --else
        --   nuerror:=1;
        --   sberror:='No se puede hacer ajuste porque contrato no cuenta con cupo disponible.';
        --end if;
       end if;
      else
       if tred='1' then -- el tt de la orden esta dentro de los tt de redes

        select orden_hija into oh
        from LDC_ORDENES_OFERTADOS_REDES
        where orden_hija=nuOtPadre
          and rownum=1; --determina orden hija

        select order_status_id,estimated_cost into eoh, ecoh
        from or_order
        where order_id=oh; -- determina estado y estimated_cost de orden hija

         ut_trace.trace('Orden de redes ingreso '||diferencia||' estado de ot hija '||eoh,10);
        if diferencia < 0 then -- disminuye valor legalizado
           if eoh<>8 then -- no esta legalizada la orden hija
				update ge_contrato
				  set valor_asignado     = nvl(valor_asignado,0) - diferencia
				where id_contrato=idcont;
				update or_order
				  set estimated_cost=nvl(estimated_cost,0) - diferencia
				where order_id=oh;
				update or_order
				   set estimated_cost=nvl(estimated_cost,0) + diferencia
			   where order_id=nuorder;
           else -- esta legalizada la orden hija

				update or_order
				   set estimated_cost=nvl(estimated_cost,0) + diferencia
				where order_id=nuorder;
           end if;
        else -- aumenta valor legalizado
           select VALOR_TOTAL_CONTRATO,valor_asignado,valor_no_liquidado,valor_liquidado
              into VALOR_TOTAL_CONTRATO,valor_asignado,valor_no_liquidado,valor_liquidado
              from ge_contrato
              where ID_CONTRATO=idcont;
           -- 200-2391 calcula cupo disponible del contrato
           cupo_disponible:=nvl(VALOR_TOTAL_CONTRATO,0) - (nvl(valor_asignado,0) + nvl(valor_no_liquidado,0) + nvl(valor_liquidado,0) + diferencia);
           --if cupo_disponible > 0 then -- tiene cupo disponible
            if eoh<>8 then -- no esta legalizada la orden hija
				 if nvl(ecoh,0) >= diferencia then
					  update ge_contrato
						   set valor_asignado     = nvl(valor_asignado,0) - diferencia--,
						   --  valor_no_liquidado = nvl(valor_no_liquidado,0) + diferencia
					  where id_contrato=idcont;

					  update or_order
						   set estimated_cost=nvl(estimated_cost,0) - diferencia
					  where order_id=oh;

					  update or_order
						   set estimated_cost=nvl(estimated_cost,0) + diferencia
					  where order_id=nuorder;
				 else
					  update ge_contrato
						   set valor_asignado     = nvl(valor_asignado,0)-(nvl(ecoh,0))--,
							-- valor_no_liquidado = nvl(valor_no_liquidado,0) + diferencia
					  where id_contrato=idcont;

					  update or_order
						   set estimated_cost=0
					  where order_id=oh;

					  update or_order
						   set estimated_cost=nvl(estimated_cost,0)+diferencia
						where order_id=nuorder;
				 end if;
            else -- ya esta legalizada
             /*update ge_contrato
                set valor_no_liquidado = nvl(valor_no_liquidado,0)+diferencia
             where id_contrato=idcont;*/
			 update or_order
				   set estimated_cost=nvl(estimated_cost,0) + diferencia
				where order_id=nuorder;

            end if;
           --else
           -- nuerror:=1;
           -- sberror:='No se puede hacer ajuste porque contrato no cuenta con cupo disponible.';
           --end if;
        end if;
       end if;
      end if;

        end if;
   --  end if;

EXCEPTION
  WHEN OTHERS THEN
    nuerror:=1;
    sberror:='Error no controlado en PRPROCMIOAIOORD '||sqlerrm;
end PRPROCMIOAIOORD;

FUNCTION proGetCostEstorden(inuorden in or_order.order_id%type) return or_order.Estimated_Cost%type IS
  /**************************************************************************
      Autor       : Horbath
      Fecha       : 2019-04-16
      Ticket      : 200-2391
      Descripcion :funcion que devuelve el costo estimado de la orden hija
      Parametros Entrada
      inuorden numero de la hora

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
      2019-04-16   horbath     creacion 200-2391
    ***************************************************************************/
  PRAGMA AUTONOMOUS_TRANSACTION;

  nuCosto or_order.Estimated_Cost%type := 0;

  --se consulta costo estimado
  CURSOR cuCostoestimado IS
  select nvl(estimated_cost,0)
  from or_order
  where order_id=inuorden;

BEGIN
  OPEN cuCostoestimado;
  FETCH cuCostoestimado INTO nuCosto;
  CLOSE cuCostoestimado;

  RETURN nuCosto;

EXCEPTION
  WHEN OTHERS THEN
    RETURN 0;
END proGetCostEstorden;

FUNCTION proGetEstadoOrden(inuorden in or_order.order_id%type) return or_order.order_status_id%type IS
  /**************************************************************************
      Autor       : Horbath
      Fecha       : 2019-04-16
      Ticket      : 200-2391
      Descripcion :funcion que devuelve el costo estimado de la orden hija
      Parametros Entrada
      inuorden numero de la hora

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
      2019-04-16   horbath     creacion 200-2391
    ***************************************************************************/
  PRAGMA AUTONOMOUS_TRANSACTION;

  nuEstado or_order.order_status_id%type;

  --se consulta costo estimado
  CURSOR cuCostoestimado IS
  select order_status_id
  from or_order, LDC_ORDENES_OFERTADOS_REDES
  where order_id = ORDEN_HIJA
    AND ORDEN_NIETA =  inuorden ;

BEGIN
  OPEN cuCostoestimado;
  FETCH cuCostoestimado INTO nuEstado;
  CLOSE cuCostoestimado;

  RETURN nuEstado;

EXCEPTION
  WHEN OTHERS THEN
    RETURN 0;
END proGetEstadoOrden;

PROCEDURE proActuaCostoEsti(inuorden in or_order.order_id%type, inucosto number) is
 /**************************************************************************
      Autor       : Horbath
      Fecha       : 2019-04-16
      Ticket      : 200-2391
      Descripcion : proceso que actualiza costo estimado d ela orden hija

    Parametros Entrada
      inuorden numero de la hora
      inucosto   costo
      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
      2019-04-16   horbath     creacion 200-2391
    ***************************************************************************/
PRAGMA AUTONOMOUS_TRANSACTION;
begin
    update or_order set estimated_cost=inucosto where order_id=inuorden;
	commit;
end proActuaCostoEsti;

PROCEDURE PRLOGPRESCONT( orden NUMBER,
						  orden_padre number,
						  estado number,
						  unidad_operativa number,
						  contrato number,
						  valor_estimado NUMBER,
						  mensa_error VARCHAR2,
						  fecha_error DATE) IS
 /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2019-10-07
      Ticket      : 200-2391
      Descripcion : Procedimiento que realiza log de datafix de presupuesto

      Parametros Entrada
       orden   			orden de trabajo
       orden_padre 		orden padre
       estado 			estado de la orden
       unidad_operativa unidad operativa
       contrato         contrato
       valor_estimado   valor estimado
	   mensa_error      mensaje de error
	   fecha_error      fecha de error

	   HISTORIA DE MODIFICACIONES
         FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
	PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN
     INSERT INTO LDC_LOGPRESCONT
				  (
					ORDEN, ORDEN_PADRE, ESTADO, UNIDAD_OPERATIVA, CONTRATO, VALOR_ESTIMADO, MENSA_ERROR, FECHA_ERROR
				  )
				  VALUES
				  (
					orden, orden_padre, estado,   UNIDAD_OPERATIVA,   CONTRATO, VALOR_ESTIMADO, MENSA_ERROR, FECHA_ERROR
				  );
	COMMIT;
  EXCEPTION
     WHEN OTHERS THEN
	     ROLLBACK;
  END PRLOGPRESCONT;
END LDC_PKGASIGNARCONT;
/
PROMPT Otorgando permisos de ejecucion a LDC_PKGASIGNARCONT
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_PKGASIGNARCONT', 'ADM_PERSON');
END;
/