create or replace PROCEDURE JOB_PRLEGORDENSACRP  IS

    /**************************************************************************
        Autor       : Ernesto Santiago / Horbath
        Fecha       : 2019-08-22
        Ticket      : 44
        Descripcion : Plugin que  permite legalizacion de ordenes de trabajo similares asignados a la misma unidad de trabajo

        Valor de salida

        HISTORIA DE MODIFICACIONES
        FECHA        AUTOR       DESCRIPCION
        12/05/2021   HORBATH     CASO 602: Obtener el comentario legalizado de la orden instanciada y legalizada
                                           Modificar el cursor CUVALOR cambiando la l¿gica de la sentencia y agregando el
                                           estado de la orden y obtener las ordenes en eatso 0 y 5
        09/07/2021   DSALTARIN   CASO 825: Se corrige forma de obtener cometnario de legalizaci¿n, para que en caso que no encuentre no arroje error.
										   Se corrige forma de obtener orden a legalizar ya que se busca en estado 0 o 5 pero siempre con unidad,
										   las ot en estado 0 no tiene cero
										    se corrige para que no legalice en este proceso ya que esta generando bloqueo
		30/11/2023   jsoto  	 Ajustes ((OSF-1883)):
								-Ajustes cambio en llamado a algunos de los objetos de producto por personalizados
								-Ajuste  cambio en manejo de trazas y errores por personalizados (pkg_error y pkg_traza).
								-Ajuste llamado a pkg_xml_soli_rev_periodica para armar los xml de las solicitudes
								-Ajuste llamado a api_legalizeorders, api_assign_order en reemplazo de api's de producto

   ***************************************************************************/

    osbErrorMessage     GE_ERROR_LOG.DESCRIPTION%TYPE;
    onuErrorCode        ge_error_log.error_log_id%type;
    -- PARAMETROS REPORTE
    nuIdReporte         reportes.reponume%type;
    sbEncabezadoDatos   repoinco.REINDES2%type;
    sbValorDatos        repoinco.reinobse%type;
    nuConsecutivo 		NUMBER :=0 ;
  	sbPrograma			VARCHAR2(100) := 'JOB_PRLEGORDENSACRP'||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');
	csbMetodo  	  		CONSTANT VARCHAR2(100) := 'JOB_PRLEGORDENSACRP';
	sbdataorder       	VARCHAR2 (2000);
    nuTipoComentario    NUMBER;

    CURSOR CUOTLEGALIZAR IS
    SELECT R.ORAPORPA OT_PADRE,
           O.ORDER_ID,
           O.ORDER_STATUS_ID,
		   O.TASK_TYPE_ID,
           R.ORAOPELE,
           R.ORAOCALE,
           R.ORAOUNID,
           OTP.EXEC_INITIAL_DATE,
           OTP.EXECUTION_FINAL_DATE,
           NVL((SELECT C.ORDER_COMMENT 
		        FROM OR_ORDER_COMMENT C 
				WHERE C.ORDER_ID=OTP.ORDER_ID 
				AND C.LEGALIZE_COMMENT='Y'),'ORDEN LEGALIZADA POR PROCESO JOB_PRLEGORDENSACRP') COMENTARIO
    FROM ldc_ordeasigproc R, OR_ORDER O, OR_ORDER OTP
    WHERE R.ORAPSOGE=O.ORDER_ID
      AND R.ORAOPROC='LEGALIZASAC'
      AND O.ORDER_STATUS_ID IN (0,5)
      AND OTP.ORDER_ID=R.ORAPORPA;
	  
	CURSOR cuTipoComentarioGen(inuTask_type_id or_order.task_type_id%TYPE) IS
		SELECT comment_type_id
		FROM or_task_type_comment
		WHERE task_type_id = inuTask_type_id
		AND comment_type_id = 1277;

	CURSOR cuTipoComentario(inuTask_type_id or_order.task_type_id%TYPE)	 IS
		SELECT comment_type_id
		FROM or_task_type_comment
		WHERE task_type_id = inuTask_type_id
		AND ROWNUM = 1;


FUNCTION fnuGetReporteEncabezado
    return number
    IS
      PRAGMA AUTONOMOUS_TRANSACTION;
        -- Variables
        rcRecord Reportes%rowtype;
    BEGIN
    --{
        -- Fill record
        rcRecord.REPOAPLI := 'LEG_SAC';
        rcRecord.REPOFECH := sysdate;
        rcRecord.REPOUSER := pkg_session.fsbgetterminal;
        rcRecord.REPODESC := 'INCONSISTENCIAS JOB DE LEGALZIACION DE SAC' ;
        rcRecord.REPOSTEJ := null;
        rcRecord.REPONUME :=  seq.getnext('SQ_REPORTES');

        -- Insert record
        pktblReportes.insRecord(rcRecord);
         COMMIT;
        return rcRecord.Reponume;
    --}
    END;

    PROCEDURE prReporteDetalle(
        inuIdReporte    in repoinco.reinrepo%type,
        inuOrden       in repoinco.reinval1%type,
        isbError        in repoinco.reinobse%type,
        isbTipo         in repoinco.reindes1%type
    )
    IS
       PRAGMA AUTONOMOUS_TRANSACTION;
        -- Variables
        rcRepoinco repoinco%rowtype;
    BEGIN
    --{
        rcRepoinco.reinrepo := inuIdReporte;
        rcRepoinco.reinval1 := inuOrden;
        rcRepoinco.reindes1 := isbTipo;
        rcRepoinco.reinobse := isbError;
        rcRepoinco.reincodi := nuConsecutivo;

        -- Insert record
        pktblRepoinco.insrecord(rcRepoinco);

        COMMIT;
    EXCEPTION
        WHEN pkg_error.controlled_error THEN
            RAISE pkg_error.controlled_error;
        WHEN OTHERS THEN
            pkg_error.setError;
            RAISE pkg_error.controlled_error;
    --}
    END;


BEGIN
		
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

        -- con estas funciones se obtienen los datos de la orden que se intentan legalizar --
        -- Inicializamos el proceso

		pkg_estaproc.prInsertaEstaproc(sbPrograma,NULL);

        nuIdReporte := fnuGetReporteEncabezado;

        FOR REG IN CUOTLEGALIZAR LOOP
          BEGIN
            onuErrorCode :=0;
            if reg.order_status_id = 0 then
                api_assign_order(reg.order_id,
                                reg.ORAOUNID,
                                onuErrorCode,
                                osberrormessage);
                IF onuErrorCode <> 0 THEN
                   rollback;
                    prReporteDetalle(nuIdReporte,
                                     REG.order_id,
                                     'Error al asignar orden :'||osberrormessage,'A' );
                else
                  commit;
                end if;
            end if;
             --Fin CASO 602
			 
     if onuErrorCode = 0 then
			
			sbdataorder := NULL;
			
			IF cuTipoComentarioGen%ISOPEN then
				CLOSE cuTipoComentarioGen;
			END IF;
			
			IF cuTipoComentario%ISOPEN then
				CLOSE cuTipoComentario;
			END IF;
			
			OPEN cuTipoComentarioGen(reg.task_type_id);
			FETCH cuTipoComentarioGen INTO nuTipoComentario;
			IF cuTipoComentarioGen%NOTFOUND then
				CLOSE cuTipoComentarioGen;
				OPEN cuTipoComentario(reg.task_type_id);
				FETCH cuTipoComentario INTO nuTipoComentario;
				CLOSE cuTipoComentario;
			END IF;
			CLOSE cuTipoComentarioGen;
			

			pkg_cadena_legalizacion.prSetDatosBasicos(reg.order_id,
													  reg.ORAOCALE,
													  reg.ORAOPELE,
													  nuTipoComentario,
													  reg.COMENTARIO);
			
			pkg_cadena_legalizacion.prAgregaActividadOrden;
			
			sbdataorder:= pkg_cadena_legalizacion.fsbCadenaLegalizacion;
			
			pkg_traza.trace('sbdataorder: '||sbdataorder);
			
			api_legalizeorders (sbdataorder,
								SYSDATE,
								SYSDATE,
								SYSDATE,
								onuErrorCode,
								osbErrorMessage
								);

			
                if (onuErrorCode <> 0) then
                   rollback;
                   prReporteDetalle(nuIdReporte,
                                     REG.order_id,
                                     'Error al legalizar orden :'||osberrormessage,'L' );
                else
                  commit;
                end if;

           end if;
          EXCEPTION
          when pkg_error.controlled_error then
               pkg_error.getError(ONUERRORCODE, OSBERRORMESSAGE);
               prReporteDetalle(nuIdReporte,
                                     REG.order_id,
                                     'Error general :'||osberrormessage,'O' );
          WHEN OTHERS THEN
               pkg_error.setError;
               pkg_error.getError(ONUERRORCODE, OSBERRORMESSAGE);
               prReporteDetalle(nuIdReporte,
                                REG.order_id,
                                'Error general :'||osberrormessage,'O' );
          END;
        END LOOP;
		pkg_estaproc.prActualizaEstaproc(sbPrograma,' Ok',osbErrorMessage);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
		
EXCEPTION
    when pkg_error.controlled_error then
     pkg_error.getError(ONUERRORCODE, OSBERRORMESSAGE);
     pkg_estaproc.prActualizaEstaproc(sbPrograma,' Con Error',osbErrorMessage);
	   pkg_traza.trace(csbMetodo||' '||osbErrorMessage);
	   pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
       RAISE pkg_error.controlled_error;
    when others then
    pkg_error.setError;
    pkg_error.getError(ONUERRORCODE, OSBERRORMESSAGE);
    pkg_estaproc.prActualizaEstaproc(sbPrograma,' Con Error',osbErrorMessage);
	pkg_traza.trace(csbMetodo||' '||osbErrorMessage);
	pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
    RAISE pkg_error.controlled_error;
END JOB_PRLEGORDENSACRP;
/