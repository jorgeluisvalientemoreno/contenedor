CREATE OR REPLACE PACKAGE ldc_pkgprocesospno IS
 /*****************************************************************************************************
    Autor       : John Jairo Jimenez Marimon
    Fecha       : 2021-08-09
    caso        :CA-592
    Descripcion : CA-592 - Paquete para los procesos de PNO
  ******************************************************************************************************/
 FUNCTION ldc_fncretornavalorn RETURN VARCHAR2;
 FUNCTION ldc_fsbvalentreregla(sbnroentrega VARCHAR2) RETURN VARCHAR2;
 FUNCTION ldc_fncvalidatrmpno(nmsusccodi NUMBER,nmnrotramite NUMBER) RETURN NUMBER;
 PROCEDURE ldc_prclegaotprerecpno;
 END ldc_pkgprocesospno;
/
CREATE OR REPLACE PACKAGE BODY ldc_pkgprocesospno IS
 /*****************************************************************************************************
    Autor       : John Jairo Jimenez Marimon
    Fecha       : 2021-08-09
    caso        :CA-592
    Descripcion : CA-592 - Paquete para los procesos de PNO
  ******************************************************************************************************/
 FUNCTION ldc_fncretornavalorn RETURN VARCHAR2 IS
 /********************************************************************************************************
    Autor       : John Jairo Jimenez Marimon
    Fecha       : 2021-08-09
    caso        :CA-592
    Descripcion : CA-592 - Retornamos valor configurado en parametro, para inicializar el dato adicional :
                  ES_RECURSO_PNO

    Parametros Entrada

    Valor de salida

   HISTORIA DE MODIFICACIONES
     FECHA        AUTOR   DESCRIPCION
 **********************************************************************************************************/
 sbvalorinicial VARCHAR2(1);
  BEGIN
   sbvalorinicial := dald_parameter.fsbGetValue_Chain('PARAM_COD_INICI_DATAD_ESRECPNO',NULL);
   RETURN nvl(TRIM(sbvalorinicial),'N');
 EXCEPTION
  WHEN OTHERS THEN
   sbvalorinicial := 'N';
   RETURN sbvalorinicial;
 END ldc_fncretornavalorn;
 --------------------------------------------------------------------------------------------------------------------
 FUNCTION ldc_fsbvalentreregla(sbnroentrega VARCHAR2) RETURN VARCHAR2 IS
 /********************************************************************************************************
    Autor       : John Jairo Jimenez Marimon
    Fecha       : 2021-08-109
    caso        :CA-592
    Descripcion : CA-592 - Funci?n que se crea para reglas de validaci?n y/o inicializacion de OSF, mediante esta funcion, se retorna
                  'S' si la entrega aplica para la gasera o 'N' en caso que no aplique.

    Parametros Entrada
    sbnroentrega Nro de la entrega
    
    Valor de salida

   HISTORIA DE MODIFICACIONES
     FECHA        AUTOR   DESCRIPCION
 **********************************************************************************************************/  
	sbvalor VARCHAR2(4); 
 BEGIN
	 IF fblaplicaentregaxcaso(sbnroentrega)THEN
		sbvalor := 'S';
	 ELSE
		sbvalor := 'N';
	 END IF;
	 
	 RETURN sbvalor;
	 
	 EXCEPTION
		WHEN OTHERS THEN
		sbvalor := 'N';
		RETURN sbvalor; 
 END ldc_fsbvalentreregla;
 --------------------------------------------------------------------------------------------------------------------
 FUNCTION ldc_fncvalidatrmpno(nmsusccodi NUMBER,nmnrotramite NUMBER) RETURN NUMBER IS
   /********************************************************************************************
    Autor       : John Jairo Jimenez Marimon
    Fecha       : 2021-08-09
    caso        :CA-592
    Descripcion : CA-592 Valida si el nro de tramite es valido y si esta asociado al contrato pasado por
                  parametro

    Parametros Entrada
      nmsusccodi     Codigo del suscriptor
      nmnrotramite   Nro del tramite PNO

    Valor de salida

   HISTORIA DE MODIFICACIONES
     FECHA        AUTOR   DESCRIPCION
  ******************************************************************************************************/
  nmproducto pr_product.product_id%TYPE;
  nmvalor    NUMBER(3);
  CURSOR cutramitepno(nmcuproducto NUMBER,nmcunrotramite NUMBER) IS
   SELECT COUNT(1) cantidad
     FROM fm_possible_ntl s
    WHERE s.product_id      = nmcuproducto
      AND s.possible_ntl_id = nmcunrotramite;
 BEGIN 
  IF nmsusccodi IS  NULL THEN
    RETURN -1;
   END IF;
  IF nmnrotramite IS NULL THEN
   RETURN -2;
  END IF;
   nmproducto := ld_bcnonbankfinancing.fnugetprodactivebycontract(nmsusccodi,7014);
  IF nmproducto IS NULL THEN
   RETURN -3;
  END IF;
  nmvalor := 0;
  FOR  i IN cutramitepno(nmproducto,nmnrotramite) LOOP
   nmvalor := i.cantidad;
  END LOOP;
  IF nmvalor >= 1 THEN
   RETURN 0;
  ELSE
   RETURN -4;
  END IF; 
EXCEPTION
  WHEN OTHERS THEN
   RETURN -5;
 END ldc_fncvalidatrmpno;
--------------------------------------------------------------------------------------------------------------------
 PROCEDURE ldc_prclegaotprerecpno IS
 /********************************************************************************************
    Autor       : John Jairo Jimenez Marimon
    Fecha       : 2021-08-11
    caso        :CA-592
    Descripcion : CA-592 Proceso masivo de legalizaci?n de ordenes de presentar cargos

    Parametros Entrada

    Valor de salida

   HISTORIA DE MODIFICACIONES
     FECHA        	AUTOR   		DESCRIPCION
	 =========		==========		==================
	 15/08/2023		jerazomvm		CASO OSF-1389:
									1. Se ajusta el manejo de errores al estandar de V8
									2. Se reemplaza el API os_legalizeorders por el API api_legalizeOrders
									3. Se reemplaza la separación de cadena LDC_BOUTILITIES.SPLITSTRINGS por 
									   SELECT to_number(regexp_substr(variable,
														'[^,]+',
														1,
														LEVEL)) AS alias
									   FROM dual
									   CONNECT BY regexp_substr(variable, '[^,]+', 1, LEVEL) IS NOT NULL
******************************************************************************************************/  
 sbCadenalega       VARCHAR2(4000);
 sbErrorMessage     VARCHAR2(4000);
 sbErrorOrdenes     VARCHAR2(4000); 
 nuCodError         NUMBER;
 nuConsecutivo      NUMBER := 0;
 nuPersona          ge_person.person_id%TYPE;
 sbmensaje          VARCHAR2(1000);
 e_errores          EXCEPTION;
 nmcausallega       ge_causal.causal_id%TYPE;
 sbdatosadicionales VARCHAR2(4000);
 nmclascausal       ge_causal.class_causal_id%TYPE;
 nuIdReporte        NUMBER;
 nuparano           NUMBER(4);
 nuparmes           NUMBER(2);
 nutsess            NUMBER;
 sbparuser          VARCHAR2(1000);
 nmotexitos         NUMBER;
 nmotnoexitos       NUMBER;
 sbesreurpno        ld_parameter.value_chain%TYPE;
 sbnrotrmpno        ld_parameter.value_chain%TYPE;
 sbParam_Tipostrab_Recursos		ld_parameter.value_chain%type	:=	DALD_PARAMETER.FSBGETVALUE_CHAIN('PARAM_TIPOSTRAB_RECURSOS', NULL);
 sbParam_Tipotrab_presrec		ld_parameter.value_chain%type	:=	DALD_PARAMETER.FSBGETVALUE_CHAIN('PARAM_TIPOTRAB_PRESREC', NULL);
 
  CURSOR cuordeneslega(sbcurecpno ld_parameter.value_chain%TYPE,sbcutrmpno ld_parameter.value_chain%TYPE) IS
   SELECT a.subscription_id
         ,(
           SELECT m.request_date 
             FROM mo_packages m
            WHERE m.package_id = a.package_id
           ) fecha_solicitud_recurso
         ,(
           SELECT f.subscriber_name||' - '||f.subs_last_name
             FROM ge_subscriber f
            WHERE f.subscriber_id = a.subscriber_id
           ) nombre_coloco_rec                                     
     FROM or_order o,or_order_activity a 
    WHERE o.task_type_id IN(SELECT to_number(regexp_substr(sbParam_Tipostrab_Recursos,
											 '[^,]+',
											 1,
											 LEVEL))
							FROM dual
							CONNECT BY regexp_substr(sbParam_Tipostrab_Recursos, '[^,]+', 1, LEVEL) IS NOT NULL)
      AND o.order_status_id = 8
      AND o.order_id = a.order_id
      AND EXISTS (
                  SELECT 1
                    FROM or_requ_data_value d
                   WHERE d.name_1       = sbcurecpno--'ES_RECURSO_PNO'
                     AND d.value_1      = 'S' 
                     AND d.order_id     = o.order_id 
                     AND d.task_type_id = o.task_type_id
                  )
      AND EXISTS (
                  SELECT 1
                    FROM or_requ_data_value d
                   WHERE d.name_1       = sbcutrmpno--'NRO_TRAMITE_PNO'
                     AND d.value_1      IS NOT NULL
                     AND d.order_id     = o.order_id 
                     AND d.task_type_id = o.task_type_id
                  )
      AND EXISTS (
                  SELECT 1
                    FROM or_order t,or_order_activity u
                   WHERE t.task_type_id IN (SELECT to_number(regexp_substr(sbParam_Tipotrab_presrec,
															 '[^,]+',
															 1,
															 LEVEL))
										    FROM dual
										    CONNECT BY regexp_substr(sbParam_Tipotrab_presrec, '[^,]+', 1, LEVEL) IS NOT NULL)
                     AND t.order_status_id = 5
                     AND t.order_id        = u.order_id
                     AND (
                          a.product_id     = ld_bcnonbankfinancing.fnugetprodactivebycontract(u.subscription_id,7014)
                          OR a.subscription_id = u.subscription_id
                         )              
                  );
----------------------------------------------------------------------------------------------------------------------------                  
 CURSOR cuordenesprescar(nmcususccodi NUMBER) IS
  SELECT t.order_id,u.order_activity_id id_actividad
    FROM or_order t,or_order_activity u
   WHERE (
          u.product_id     = ld_bcnonbankfinancing.fnugetprodactivebycontract(nmcususccodi,7014)
          OR u.subscription_id = nmcususccodi
         )
     AND t.task_type_id IN(SELECT to_number(regexp_substr(sbParam_Tipotrab_presrec,
											'[^,]+',
											1,
											LEVEL))
						   FROM dual
						  CONNECT BY regexp_substr(sbParam_Tipotrab_presrec, '[^,]+', 1, LEVEL) IS NOT NULL)
     AND t.order_status_id = 5
     AND t.order_id        = u.order_id;
----------------------------------------------------------------------------------------------------------------------------     
FUNCTION fnuCrReportHeader RETURN NUMBER IS
 PRAGMA AUTONOMOUS_TRANSACTION;
 -- Variables
  rcRecord Reportes%ROWTYPE;
 BEGIN
 
	ut_trace.trace('Inicio LDC_PKGPROCESOSPNO.fnuCrReportHeader', 2);
															
  -- Fill record
  rcRecord.REPOAPLI := 'LEGAPREREC';
  rcRecord.REPOFECH := SYSDATE;
  rcRecord.REPOUSER := ut_session.getTerminal;
  rcRecord.REPODESC := 'INCONSISTENCIAS JOB LEGALIZACIONES AUTOMATICAS PRESENTAR RECURSOS' ;
  rcRecord.REPOSTEJ := NULL;
  rcRecord.REPONUME :=  seq.getnext('SQ_REPORTES');
  -- Insert record
  pktblReportes.insRecord(rcRecord);
  COMMIT;
  
  ut_trace.trace('Finaliza LDC_PKGPROCESOSPNO.fnuCrReportHeader rcRecord.Reponume: ' || rcRecord.Reponume, 2);
  
  RETURN rcRecord.Reponume;
  --}
 EXCEPTION
  WHEN pkg_error.controlled_error THEN
	ut_trace.trace('pkg_error.controlled_error LDC_PKGPROCESOSPNO.fnuCrReportHeader', 2);
    RAISE pkg_error.controlled_error;
  WHEN OTHERS THEN
	ut_trace.trace('OTHERS LDC_PKGPROCESOSPNO.fnuCrReportHeader', 2);
    pkg_error.seterror;
    RAISE pkg_error.controlled_error;
 END;

/***********************************************************************************************************************************
    Autor       : 
    Fecha       : 
    Ticket      : 
    Descripcion : 
	
	Parametros:				
	===========================================
	inuIdReporte		Número del reporte
	inuProduct			Valor 1
	isbError			Observaciones
	isbTipo				Descripción 1
	
    
    
    HISTORIAL DE MODIFICACIONES
    =========       =========     =========         ====================
      Fecha          Ticket         Autor           Modificacion
    =========       =========     =========         ====================
	15/08/2023		OSF-1389	 jerazomvm			Caso OSF-1389:
													1. Se ajusta el manejo de errores al estandar de V8
													2. Se reemplaza el API os_legalizeorders por el API api_legalizeOrders
**************************************************************************************************************************************/
	 PROCEDURE crReportDetail(
							  inuIdReporte IN repoinco.reinrepo%TYPE,
							  inuProduct   IN repoinco.reinval1%TYPE,
							  isbError     IN repoinco.reinobse%TYPE,
							  isbTipo      IN repoinco.reindes1%TYPE
							 ) IS
	 PRAGMA AUTONOMOUS_TRANSACTION;
	  -- Variables
	  rcRepoinco repoinco%rowtype;
	  
	 BEGIN
	 
		ut_trace.trace('Inicio LDC_PKGPROCESOSPNO.crReportDetail inuIdReporte: ' || inuIdReporte || chr(10) ||
																'inuProduct: ' 	 || inuProduct 	 || chr(10) ||
																'isbError: ' 	 || isbError 	 || chr(10) ||
																'isbTipo: ' 	 || isbTipo, 2);
		--{
	  rcRepoinco.reinrepo := inuIdReporte;
	  rcRepoinco.reinval1 := inuProduct;
	  rcRepoinco.reindes1 := isbTipo;
	  rcRepoinco.reinobse := isbError;
	  rcRepoinco.reincodi := nuConsecutivo;
	  -- Insert record
	  pktblRepoinco.insrecord(rcRepoinco);
	  COMMIT;
	  
	  ut_trace.trace('Finaliza LDC_PKGPROCESOSPNO.crReportDetail', 2);
	  
	 EXCEPTION
	  WHEN pkg_error.controlled_error THEN
		ut_trace.trace('pkg_error.controlled_error LDC_PKGPROCESOSPNO.crReportDetail', 2);
		RAISE pkg_error.controlled_error;
	  WHEN OTHERS THEN
		ut_trace.trace('OTHERS LDC_PKGPROCESOSPNO.crReportDetail', 2);
		pkg_error.seterror;
		RAISE pkg_error.controlled_error;
		--}
	 END;  
 
BEGIN -- Programa principal

	ut_trace.trace('Inicio LDC_PKGPROCESOSPNO.ldc_prclegaotprerecpno', 2);

	 sbmensaje          := 'OK';
	 sbdatosadicionales := NULL;
	 nmotexitos         := 0;
	 nmotnoexitos       := 0;
	 
		SELECT to_number(to_char(SYSDATE,'YYYY'))
			   ,to_number(to_char(SYSDATE,'MM'))
			   ,userenv('SESSIONID')
			   ,USER INTO nuparano,nuparmes,nutsess,sbparuser
		FROM dual;
	   
		-- Se inicia log del programa
		ldc_proinsertaestaprog(nuparano,nuparmes,'LDC_PKGPROCESOSPNO.LDC_PRCLEGAOTPRERECPNO','En ejecucion',nutsess,sbparuser); 
	  
		-- Obtenemos la causal de legalizaci?n del parametro 
		nmcausallega := dald_parameter.fnuGetNumeric_Value('PARAM_CAUSAL_LEGA_PRESECARG',NULL);
		ut_trace.trace('nmcausallega: ' || nmcausallega, 4);
	  
		  IF nmcausallega IS NULL THEN
			sbmensaje := 'SE DEBE CONFIGURAR EL CODIGO DE LA CAUSAL PRESENTAR CARGOS, EN EL PARAMETRO : PARAM_CAUSAL_LEGA_PRESECARG MEDIANTE LA FORMA LDPAR.';
			RAISE e_errores;
		  END IF;
	  
		-- Obtenemos la persona que legaliza del parametro 
		nupersona := dald_parameter.fnuGetNumeric_Value('PARAM_PERSONA_LEGA_PRESCARG',NULL); 
		ut_trace.trace('nupersona: ' || nupersona, 4);
	  
		IF nupersona IS NULL THEN
			sbmensaje := 'SE DEBE CONFIGURAR LA PERSONA QUE LEGALIZARA LAS ORDENES DE PRESENTAR CARGOS, EN EL PARAMETRO : PARAM_PERSONA_LEGA_PRESCARG MEDIANTE LA FORMA LDPAR.';
			RAISE e_errores;
		END IF;
	  
		-- Obtenemos el dato adicional es recurso PNO
		sbesreurpno :=  dald_parameter.fsbGetValue_Chain('PARAM_COD_DATADIC_RECURSO_PNO',NULL);
		ut_trace.trace('sbesreurpno: ' || sbesreurpno, 4);
	  
		IF sbesreurpno IS NULL THEN
			sbmensaje := 'SE DEBE CONFIGURAR EL NOMBRE DEL DATO ADICIONAL ES_RECURSO_PNO, EN EL PARAMETRO : PARAM_COD_DATADIC_RECURSO_PNO MEDIANTE LA FORMA LDPAR.';
			RAISE e_errores;
		ELSE
			sbesreurpno := TRIM(sbesreurpno);
		END IF;
	  
		-- Obtenemos el dato adicional nro tramite pno
		sbnrotrmpno :=  dald_parameter.fsbGetValue_Chain('PARAM_COD_DATADIC_NROTRM_PNO',NULL);
		ut_trace.trace('sbnrotrmpno: ' || sbnrotrmpno, 4);
	  
		IF sbnrotrmpno IS NULL THEN
			sbmensaje := 'SE DEBE CONFIGURAR EL NOMBRE DEL DATO ADICIONAL NRO_TRAMITE_PNO, EN EL PARAMETRO : PARAM_COD_DATADIC_NROTRM_PNO MEDIANTE LA FORMA LDPAR.';
			RAISE e_errores;
		ELSE
			sbnrotrmpno := TRIM(sbnrotrmpno);
		END IF;  
	  
		-- Obtenemos la clase de causal
		nmclascausal := dage_causal.fnugetclass_causal_id(nmcausallega,NULL);
		ut_trace.trace('nmclascausal: ' || nmclascausal, 4);
	  
		IF nmclascausal IS NULL THEN
			sbmensaje := 'LA CAUSAL : '||nmcausallega||' NO TIENE CONFIGURADO CLASE DE CAUSAL, FAVOR VALIDAR.'; 
			RAISE e_errores;
		END IF;
	  
		IF nmclascausal = 1 THEN
			nmclascausal := 1;
		ELSE
			nmclascausal := 0;  
		END IF;  
	  
		  FOR i IN cuordeneslega(sbesreurpno,sbnrotrmpno) LOOP
			   nuIdReporte := fnuCrReportHeader; 
			   
			   FOR j IN cuordenesprescar(i.subscription_id) LOOP
					-- Datos adicionales
					sbdatosadicionales := 'FECH_RECUR='||to_char(i.fecha_solicitud_recurso)||';'||'USUA_NOM='||i.nombre_coloco_rec; 
					
					-- Cadena de legalizaci?n
					sbCadenalega := j.order_id||'|'||nmcausallega||'|'||nuPersona||'|'||sbdatosadicionales||'|'||j.id_actividad     ||'>'||nmclascausal      ||';;;;|||1292;INFORMACI?N DE MEDICI?N Y P?RDIDAS';  
					
					ut_trace.trace('Ingresa api_legalizeOrders isbDataOrder: ' 	|| sbCadenalega || chr(10) ||
															  'idtInitDate: ' 	|| SYSDATE 		|| chr(10) ||
															  'idtFinalDate: ' 	|| SYSDATE 		|| chr(10) ||
															  'idtChangeDate: '	|| null, 6);
					
					-- Legalizamos la orden
					api_legalizeOrders(sbCadenalega, 
									   SYSDATE, 
									   SYSDATE, 
									   null, 
									   nuCodError, 
									   sbErrorMessage 
									   );
									   
					ut_trace.trace('Sale api_legalizeOrders onuErrorCode: ' 	|| nuCodError || chr(10) ||
														   'osbErrorMessage: ' 	|| sbErrorMessage, 6);
					
					-- Validamos si se present? error   
					IF  nuCodError <> 0 THEN
						 sbErrorOrdenes := substr(sbErrorOrdenes ||' Orden '||j.order_id||' con error '||sbErrorMessage, 0, 3999); 
						 ROLLBACK;
						 -- Reporte de errores 
						 nuConsecutivo := nuConsecutivo +1;
						 crReportDetail(
										nuIdReporte
									   ,j.order_id
									   ,sbErrorMessage
									   ,'S'
									   );
						 nmotnoexitos := nmotnoexitos + 1;                   
					ELSE
						 COMMIT;
						 nmotexitos := nmotexitos + 1; 
					END IF;
					
			   END LOOP;
		  END LOOP;
	  
	  ldc_proactualizaestaprog(nutsess,'Proceso termin? Ok. Se legelizar?n de forma exitosa : '||to_char(nmotexitos)||' ordenes, de forma no-exitosa : '||to_char(nmotnoexitos)||' ordenes.','LDC_PKGPROCESOSPNO.LDC_PRCLEGAOTPRERECPNO','OK');
	 
	 ut_trace.trace('Finaliza LDC_PKGPROCESOSPNO.ldc_prclegaotprerecpno', 2);
 
EXCEPTION
 WHEN e_errores THEN
	ut_trace.trace('e_errores LDC_PKGPROCESOSPNO.ldc_prclegaotprerecpno', 2);
	ldc_proactualizaestaprog(nutsess,sbmensaje,'LDC_PKGPROCESOSPNO.LDC_PRCLEGAOTPRERECPNO','Proceso termin? con errores');
	ROLLBACK;   
  WHEN OTHERS THEN
	ut_trace.trace('OTHERS LDC_PKGPROCESOSPNO.ldc_prclegaotprerecpno', 2);
	sbmensaje := SQLERRM;
	ldc_proactualizaestaprog(nutsess,sbmensaje,'LDC_PKGPROCESOSPNO.LDC_PRCLEGAOTPRERECPNO','Proceso termin? con errores');
	ROLLBACK;
 END ldc_prclegaotprerecpno;
 
END ldc_pkgprocesospno;
/
GRANT EXECUTE ON LDC_PKGPROCESOSPNO TO SYSTEM_OBJ_PRIVS_ROLE;
/