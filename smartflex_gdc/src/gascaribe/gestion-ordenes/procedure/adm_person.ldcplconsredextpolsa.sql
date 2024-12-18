create or replace PROCEDURE adm_person.ldcplconsredextpolsa IS
/******************************************************************************************************************************************
Autor       : Jhon Jimenez / Horbath
Fecha       : 2019-11-27
Ticket      : 40
Descripcion : Prugin asignacion de orden relacionadas

Parametros Entrada

HISTORIA DE MODIFICACIONES
 FECHA         	AUTOR       			   DESCRIPCION
30/06/2020      John Jairo Jimenez         Se modifica el cursor cuGetOrdenAsignar para que consulte la solicitud y direccion
                                           de las ordenes de verificacion de anillo asociada a la oreden que se esta legalizando
										   con estos datos buscar las ordenes bloquedas de los tipos de trabajo configurados en el
										   parametro : TITR_DESB_DISENO_REUBIC_ANILLO y con la causal configurada en el parametro :
										   PARAM_CAUS_DESBLOQ_REUB_ANILLO.
										   En caso que la orden bloqueada no tenga causal, se procede a buscar la orden padre de los
										   tipos de trabajos antes mencionados y con la causal configurada en el parametro antes mecionado.
24/04/2024      Adrianavg                  OSF-2597: Se migra del esquema OPEN al esquema ADM_PERSON                                                         
******************************************************************************************************************************************/
 nuOrden NUMBER; --se almacena orden de trabajo que se esta legalizando
 nuTipoCo NUMBER; --se almacena tipo de comentario
 sbComentario VARCHAR2(4000);
 nuUnidadDummy NUMBER := dald_parameter.fnuGetNumeric_Value('UNI_OPER_DUMMY_LDRORDMO',0);
 sbTitr VARCHAR2(4000) := DALD_PARAMETER.FSBGETVALUE_CHAIN('TITR_DESB_DISENO_REUBIC_ANILLO', NULL);
 nmcontacausal NUMBER(6);
 nmcuordendesbl or_order.order_id%TYPE;

 /*Cambio de alcance 0000040_5: Se consulta la solicitud y direccion de las ordenes de verificacion de anillo
    asociada a la oreden que se esta legalizando*/

 CURSOR cuGetOrdenAsignar IS
 /*SELECT O.order_id
 FROM or_order_activity oa, or_order_activity oai, OR_ORDER O
 WHERE oai.package_id = oa.package_id
  AND oa.order_id = nuOrden
  AND o.order_id = oai.order_id
  AND o.task_type_id in ( SELECT  to_number(COLUMN_VALUE)
                            FROM TABLE(open.ldc_boutilities.splitstrings(sbTitr,',')))
  AND o.order_status_id = 11;*/
  SELECT ac.package_id solicitud,ac.address_id direccion
    FROM or_related_order ro,or_order_activity ac
   WHERE ro.order_id = nuOrden
     AND ro.related_order_id = ac.order_id
     AND ac.activity_id IN(SELECT to_number(COLUMN_VALUE) verificacion_anillo
                             FROM TABLE(open.ldc_boutilities.splitstrings(dald_parameter.fsbGetValue_Chain('ACTIV_VERIFICACION_DE_ANILL',null),',')));

 --Cambio de alcance 0000040_5 : Se consulta orden bloqueadas a desbloquear
 CURSOR cuOrdenesbloq(
                      nmcupackage_id or_order_activity.package_id%TYPE
					           ,nmcuaddress_id or_order_activity.address_id%TYPE
					 ) IS
  SELECT ot.order_id,ot.causal_id
    FROM or_order_activity ac,or_order ot
   WHERE ac.package_id = nmcupackage_id
     AND ac.address_id = nmcuaddress_id
     AND ot.task_type_id IN(SELECT to_number(COLUMN_VALUE)
                              FROM TABLE(open.ldc_boutilities.splitstrings(sbTitr,',')))
     AND ot.order_status_id = 11
     AND ac.order_id = ot.order_id;

 --Cambio de alcance 0000040_5 : Obtenemos la orden padre bloqueada con causal para desbloquear de la orden hija bloqueda que no tiene causal
 CURSOR cuOrdenespadres(nmcuothija or_order.order_id%TYPE) IS
  SELECT otp.order_id otpadre
    FROM or_related_order op,or_order otp
   WHERE op.related_order_id = nmcuothija
     AND op.order_id = otp.order_id
     AND otp.task_type_id IN (SELECT to_number(COLUMN_VALUE)
                                FROM TABLE(open.ldc_boutilities.splitstrings(sbTitr,',')))
     --AND otp.order_status_id = 11
     AND otp.causal_id IN(SELECT to_number(COLUMN_VALUE)
                            FROM TABLE(open.ldc_boutilities.splitstrings(dald_parameter.fsbGetValue_Chain('PARAM_CAUS_DESBLOQ_REUB_ANILLO'),',')));

  --se valida si la orden estuvo asignada
  CURSOR cuOrderAssigend(inuOrderId   or_order.order_id%type)   IS
  SELECT  or_order_stat_change.final_oper_unit_id unidad_trabajo
  FROM    or_order_stat_change
  WHERE   or_order_stat_change.order_id = inuOrderId
	AND     or_order_stat_change.final_status_id = OR_BOCONSTANTS.CNUORDER_STAT_ASSIGNED
	AND     or_order_stat_change.final_oper_unit_id is not null;

  --obtiene ultima unidad asignada
  CURSOR cuEndOperUniAssigend(inuOrderId   or_order.order_id%type)	IS
   SELECT  or_order_opeuni_chan.target_oper_unit_id
   FROM    or_order_opeuni_chan
   WHERE   or_order_opeuni_chan.order_id = inuOrderId
	 AND     or_order_opeuni_chan.target_oper_unit_id is not null
  ORDER BY or_order_opeuni_chan.register_date DESC;

  --se obtiene tipo de comentario
  CURSOR cuTipocoment IS
  select COMMENT_TYPE_ID
  from GE_COMMENT_TYPE
  WHERE COMMENT_CLASS_ID = 20 ;

  error NUMBER;
  sbmensa VARCHAR2(4000);
  nuInitialOperUni NUMBER;
  nuEndOperUni NUMBER;

	-- PARAMETROS REPORTE
	nuIdReporte         reportes.reponume%type;
--	sbEncabezadoDatos   repoinco.REINDES2%type;
	--sbValorDatos        repoinco.reinobse%type;
    nuConsecutivo      number:=0;

	-- crear cabecera deL reporte de seguimiento
	FUNCTION fnuCrReportHeader
	return number
	IS
	  rcRecord Reportes%rowtype;
	BEGIN
	  rcRecord.REPOAPLI := 'DESASIORDE';
	  rcRecord.REPOFECH := sysdate;
	  rcRecord.REPOUSER := ut_session.getTerminal;
	  rcRecord.REPODESC := 'INCONSISTENCIAS PLUGIN DE DESBLOQUEO LDCPLCONSREDEXTPOLSA' ;
	  rcRecord.REPOSTEJ := null;
	  rcRecord.REPONUME :=  seq.getnext('SQ_REPORTES');
	  pktblReportes.insRecord(rcRecord);
	  return rcRecord.Reponume;
	END ;
	--crea detalle de reporte
	PROCEDURE crReportDetail(
						  inuIdReporte	in  repoinco.reinrepo%type,
						  inuProduct	in  repoinco.REINVAL1%type,
						  isError	in  repoinco.REINOBSE%type,
						  isbTipo in repoinco.reindes1%type
						  )
	IS
	  rcRepoinco repoinco%rowtype;
	BEGIN
	  rcRepoinco.Reinrepo := inuIdReporte;
	  rcRepoinco.REINVAL1 := inuProduct;
	  rcRepoinco.REINDES1 := isbTipo;
	  rcRepoinco.REINOBSE := isError;
	  rcRepoinco.reincodi := nuConsecutivo;
	  pktblRepoinco.insrecord(rcRepoinco);
	EXCEPTION
	   WHEN OTHERS THEN
	     ut_trace.trace('ERROR  fnuCrReportHeader'||SQLERRM, 10);
	END ;

BEGIN
  ut_trace.trace('Inicia LDCPLCONSREDEXTPOLSA', 10);

  --se valida si aplica la entrega
  IF FBLAPLICAENTREGAXCASO('0000040') THEN
     nuOrden := or_bolegalizeorder.fnuGetCurrentOrder; -- Obtenemos la orden que se esta legalizando

     sbComentario := 'Desbloqueo de orden por legalizacion de orden['||nuOrden||']';

     --se consulta tipo de comentario
     OPEN cuTipocoment;
     FETCH cuTipocoment INTO nuTipoCo;
     CLOSE cuTipocoment;

     nuIdReporte := fnuCrReportHeader; --se crea encabezado de reporte

     -- Inicio Cambio de alcance 0000040_5 se consulta orden a desbloquear y asignar
     FOR reg IN cuGetOrdenAsignar LOOP
       nmcuordendesbl := NULL;
      FOR des IN cuOrdenesbloq(reg.solicitud,reg.direccion) LOOP
       IF des.causal_id IS NULL THEN
			FOR otpad IN cuOrdenespadres(des.order_id) LOOP
			 --  se hace llamado al proceso que desbloquea la orden
			 or_bofwlockorder.unlockorder(
										  des.order_id,
										  nuTipoCo,
										  sbComentario
										 );
			 nmcuordendesbl := des.order_id;
			END LOOP;
       ELSE
        SELECT count(1) INTO nmcontacausal
          FROM (
                SELECT to_number(COLUMN_VALUE) causal
                  FROM TABLE(open.ldc_boutilities.splitstrings(dald_parameter.fsbGetValue_Chain('PARAM_CAUS_DESBLOQ_REUB_ANILLO'),','))
                )
         WHERE causal = des.causal_id;
         IF nmcontacausal >= 1 THEN
          --  se hace llamado al proceso que desbloquea la orden
          or_bofwlockorder.unlockorder(
                                       des.order_id,
                                       nuTipoCo,
                                       sbComentario
                                      );
          nmcuordendesbl := des.order_id;
         END IF;
       END IF;
       IF nmcuordendesbl IS NOT NULL THEN
        nuInitialOperUni := null;
        nuEndOperUni := null;
        error := NULL;
        sbmensa := NULL;
        -- Se valida si la orden estuvo asignada
         OPEN cuOrderAssigend(nmcuordendesbl);
        FETCH cuOrderAssigend INTO nuInitialOperUni;
        CLOSE cuOrderAssigend;

        IF nuInitialOperUni IS NOT NULL THEN
           -- Se Obtiene la ultima unidad a la que estuvo asignada
          OPEN cuEndOperUniAssigend(nmcuordendesbl);
          FETCH cuEndOperUniAssigend INTO nuEndOperUni;
          CLOSE cuEndOperUniAssigend;

          IF nuEndOperUni IS NULL THEN
            nuEndOperUni := nuInitialOperUni;
          END IF;

           -- Se asigna la orden
          OS_ASSIGN_ORDER
          (
            nmcuordendesbl,
            nuEndOperUni,
            ut_date.fdtsysdate,
            ut_date.fdtsysdate,
            error,
            sbmensa
          );
          IF error <> 0 THEN
            --se crea log
            nuConsecutivo := nuConsecutivo +1;
            crReportDetail(nuIdReporte,nmcuordendesbl,sbmensa, 'S');

            error := NULL;
            sbmensa := NULL;

            OS_ASSIGN_ORDER
            (
              nmcuordendesbl,
              nuUnidadDummy,
              ut_date.fdtsysdate,
              ut_date.fdtsysdate,
              error,
              sbmensa
            );
           IF error <> 0 THEN
                --se crea log
                nuConsecutivo := nuConsecutivo +1;
                crReportDetail(nuIdReporte,nmcuordendesbl,sbmensa, 'S');
           END IF;
          END IF;
        ELSE
         --se asigna orden de trabajo
         OS_ASSIGN_ORDER
          (
            nmcuordendesbl,
            nuUnidadDummy,
            ut_date.fdtsysdate,
            ut_date.fdtsysdate,
            error,
            sbmensa
          );

        IF error <> 0 THEN
           --se crea log
          nuConsecutivo := nuConsecutivo +1;
          crReportDetail(nuIdReporte,nmcuordendesbl,sbmensa, 'S');
        END IF;
       END IF;


       -------------------------------------------------

       END IF;
      END LOOP;
     END LOOP;
	 -- Fin Cambio de alcance 0000040_5
  end If;
  ut_trace.trace('FIN LDCPLCONSREDEXTPOLSA', 10);
EXCEPTION
    when ex.CONTROLLED_ERROR then
      Errors.getError(error, sbmensa);
      raise ex.CONTROLLED_ERROR;
    when OTHERS then
      Errors.getError(error, sbmensa);
      raise ex.CONTROLLED_ERROR;
END LDCPLCONSREDEXTPOLSA;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre procedimiento LDCPLCONSREDEXTPOLSA
BEGIN
    pkg_utilidades.prAplicarPermisos('LDCPLCONSREDEXTPOLSA', 'ADM_PERSON'); 
END;
/