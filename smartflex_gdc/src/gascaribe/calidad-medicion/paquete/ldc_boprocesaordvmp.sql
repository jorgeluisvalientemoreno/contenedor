CREATE OR REPLACE PACKAGE LDC_BoProcesaOrdVMP IS

  FUNCTION pGestionaOrdenVMP(inuPackage_id IN NUMBER) RETURN NUMBER;
  /**************************************************************************
   Autor       : Daniel Valiente / Horbath
   Fecha       : 2020-12-23
   Ticket      : 263
   Proceso     : pGestionaOrdenVMP
   Descripcion : funcion para gestionar ordenes de Suspension VPM
  
   HISTORIA DE MODIFICACIONES
   FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/

  PROCEDURE pProcesaOrdNotifSusp;
  /**************************************************************************
   Autor       : Daniel Valiente / Horbath
   Fecha       : 2020-12-23
   Ticket      : 263
   Proceso     : pProcesaOrdNotifSusp
   Descripcion : procedimiento para validar la creacion masiva de tramites de suspension
  
   HISTORIA DE MODIFICACIONES
   FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/

  PROCEDURE pProcesaOrdSuspCalimed;
  /**************************************************************************
   Autor       : Daniel Valiente / Horbath
   Fecha       : 2020-12-23
   Ticket      : 263
   Proceso     : pProcesaOrdSuspCalimed
   Descripcion : procedimiento para validar la creacion masiva de tramites de suspension por calidad de medicion
  
   HISTORIA DE MODIFICACIONES
   FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/

  PROCEDURE pGenVSI_UsuAutoriza;
  /**************************************************************************
   Autor       : Daniel Valiente / Horbath
   Fecha       : 2020-12-23
   Ticket      : 263
   Proceso     : pGenVSI_UsuAutoriza 
   Descripcion : procedimiento para generar VSI de productos suspendidos
  
   HISTORIA DE MODIFICACIONES
   FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/

  PROCEDURE pGenSusp_UsuNoAutoriza;
  /**************************************************************************
   Autor       : Daniel Valiente / Horbath
   Fecha       : 2020-12-23
   Ticket      : 263
   Proceso     : pGenSusp_UsuNoAutoriza 
   Descripcion : procedimiento para generar ordenes sobre productos suspendidos
  
   HISTORIA DE MODIFICACIONES
   FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/

  FUNCTION pValidaActividadVSI(nuactivity IN NUMBER, nusubscription_id IN NUMBER, sbMensaje OUT varchar2)
    RETURN NUMBER;
  /**************************************************************************
   Autor       : Daniel Valiente / Horbath
   Fecha       : 2020-12-23
   Ticket      : 263
   Proceso     : pValidaActividadVSI 
   Descripcion : Valida si la actividad seleccionada corresponde a la actividad de suspensión indicada
  
   HISTORIA DE MODIFICACIONES
   FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/

  PROCEDURE pPluginGeneraReconexion;
  /**************************************************************************
   Autor       : Daniel Valiente / Horbath
   Fecha       : 2020-12-23
   Ticket      : 263
   Proceso     : pPluginGeneraReconexion 
   Descripcion : procedimiento para validar si creará el trámite de reconexión
  
   HISTORIA DE MODIFICACIONES
   FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/

  FUNCTION pGestionaOrdenVMP_RECO(inuPackage_id     IN NUMBER,
                                  isbtypesuspension IN varchar2)
    RETURN NUMBER;
  /**************************************************************************
   Autor       : Daniel Valiente / Horbath
   Fecha       : 2020-12-23
   Ticket      : 263
   Proceso     : pGestionaOrdenVMP_RECO
   Descripcion : funcion para gestionar ordenes de Reconexion VPM
  
   HISTORIA DE MODIFICACIONES
   FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/

  PROCEDURE pJobGeneraReconexion;
  /**************************************************************************
   Autor       : Daniel Valiente / Horbath
   Fecha       : 2020-12-23
   Ticket      : 263
   Proceso     : pJobGeneraReconexion 
   Descripcion : procedimiento para legalizar reconexión
  
   HISTORIA DE MODIFICACIONES
   FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/

  PROCEDURE pProcesaOrdParaAnuServ;
  /**************************************************************************
   Autor       : Daniel Valiente / Horbath
   Fecha       : 2020-12-23
   Ticket      : 263
   Proceso     : pProcesaOrdParaAnuServ
   Descripcion : procedimiento para validar la creacion masiva de VSI
  
   HISTORIA DE MODIFICACIONES
   FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/

  FUNCTION pValidaTipoSuspension(inuProduct_id IN NUMBER) RETURN varchar2;
  /**************************************************************************
   Autor       : Daniel Valiente / Horbath
   Fecha       : 2020-12-23
   Ticket      : 263
   Proceso     : pValidaTipoSuspension
   Descripcion : Valida el tipo de Suspension Aplicado al Producto AC / CM
  
   HISTORIA DE MODIFICACIONES
   FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
  
  PROCEDURE pProcPlugCambMed;
  /**************************************************************************
   Autor       : dsaltarin
   Fecha       : 2020-12-23
   Ticket      : 263
   Proceso     : pProcPlugCambMed
   Descripcion : procedimiento plugin para validar si hubo cambio de medidor
  
   HISTORIA DE MODIFICACIONES
   FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/  
  
  FUNCTION fsbValidaCambMed(inuProduct_id IN NUMBER,
                            dtFecha       IN date) RETURN varchar2;
  /**************************************************************************
   Autor       : dsaltarin
   Fecha       : 2020-12-23
   Ticket      : 263
   Proceso     : fsbValidaCambMed
   Descripcion : funcion que valida si hubo cambio de medidor.
  
   HISTORIA DE MODIFICACIONES
   FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
    
  PROCEDURE pPluginGeneraSusAcoVpm;  
  PROCEDURE pPluginGeneraSusAconoCambio;
  PROCEDURE pPluginCancSuspCLM;  
  

END LDC_BoProcesaOrdVMP;
/
create or replace PACKAGE BODY LDC_BoProcesaOrdVMP IS

    /**************************************************************************
     Autor       : Daniel Valiente / Horbath
     Fecha       : 2020-12-23
     Ticket      : 263
     Proceso     : BoProcesaOrdVMP
     Descripcion : Paquete con las funcionalidades para gestionar ordenes y solicitudes
                   VPM.

     HISTORIA DE MODIFICACIONES
     FECHA        AUTOR       DESCRIPCION
     26/09/2023   jsoto       Ajustes a la lógica del paquete reemplazando llamados a objetos de
                              producto OPEN por objetos personalizados y otros ajustes descritos 
                              en el caso OSF-1609.
    ***************************************************************************/

    csbPluginCancSuspCLM    CONSTANT VARCHAR2(30) := 'pPluginCancSuspCLM';

    cnuVAL_EXIS_PARAM       CONSTANT NUMBER(1) := NULL;
	
	    -- Constantes para el control de la traza
    csbSP_NAME 	CONSTANT VARCHAR2(35):= 'LDC_BoProcesaOrdVMP';
    cnuNVLTRC 	CONSTANT NUMBER := pkg_traza.cnuNivelTrzDef;
	csbInicio   CONSTANT VARCHAR2(35) := pkg_traza.fsbINICIO;


  FUNCTION pGestionaOrdenVMP(inuPackage_id IN NUMBER) RETURN NUMBER IS
    /**************************************************************************
     Autor       : Daniel Valiente / Horbath
     Fecha       : 2020-12-23
     Ticket      : 263
     Proceso     : pGestionaOrdenVMP
     Descripcion : funcion para gestionar ordenes de Suspension VPM

     HISTORIA DE MODIFICACIONES
     FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    onuErrorCode NUMBER;
    sbmensa      VARCHAR2(4000);
    nu_causal  NUMBER;
    nu_tiposol NUMBER;
    nu_causalnocambed NUMBER;
    nu_causal_aco     NUMBER;
    nu_causalnocambed_aco     NUMBER;
    csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.pGestionaOrdenVMP';


    CURSOR cuCausal IS	
    SELECT COUNT(*)
      FROM MO_MOTIVE MM, CC_CAUSAL CC
     WHERE MM.CAUSAL_ID = CC.CAUSAL_ID
       AND mm.package_id = inuPackage_id
       AND CC.CAUSAL_ID IN
           (dald_parameter.fnuGetNumeric_Value('PAR_C_SUSP_CDM', NULL)) -- causal 
       AND CC.CAUSAL_TYPE_ID IN
           (dald_parameter.fnuGetNumeric_Value('PAR_TC_SUSP_CDM', NULL)); -- tipo de causal

   CURSOR cuTipoSolicitud	IS

    SELECT COUNT(*)
      FROM mo_packages mp
     WHERE mp.package_id = inuPackage_id
       AND mp.package_type_id IN
	       (SELECT regexp_substr(dald_parameter.fsbgetvalue_chain('PAR_TIPOSOLIC_SUSP',NULL), '[^,]+', 1, LEVEL)AS Solicitud
		    FROM dual
			CONNECT BY regexp_substr(dald_parameter.fsbgetvalue_chain('PAR_TIPOSOLIC_SUSP', NULL), '[^,]+', 1, LEVEL) IS NOT NULL); --tipo de la solicitud 


    CURSOR cuCausalNoCamMed IS
    SELECT COUNT(*)
      FROM MO_MOTIVE MM, CC_CAUSAL CC
     WHERE MM.CAUSAL_ID = CC.CAUSAL_ID
       AND mm.package_id = inuPackage_id
       AND CC.CAUSAL_ID IN
           (dald_parameter.fnuGetNumeric_Value('PAR_C_SUSP_CDM_XNCAMMED', NULL)) -- causal 
       AND CC.CAUSAL_TYPE_ID IN
           (dald_parameter.fnuGetNumeric_Value('PAR_TC_SUSP_CDM', NULL)); -- tipo de causal

        --causal y tipo causal de la solicitud
    CURSOR cuCausalSolicitud IS
	SELECT COUNT(*)
      FROM MO_MOTIVE MM, CC_CAUSAL CC
     WHERE MM.CAUSAL_ID = CC.CAUSAL_ID
       AND mm.package_id = inuPackage_id
       AND CC.CAUSAL_ID IN
           (dald_parameter.fnuGetNumeric_Value('PAR_C_SUSP_ACO', NULL)) -- causal 
       AND CC.CAUSAL_TYPE_ID IN
           (dald_parameter.fnuGetNumeric_Value('PAR_TC_SUSP_CDM', NULL)); -- tipo de causal       

    CURSOR cuCausalNoCamMedAco IS
	SELECT COUNT(*)
      FROM MO_MOTIVE MM, CC_CAUSAL CC
     WHERE MM.CAUSAL_ID = CC.CAUSAL_ID
       AND mm.package_id = inuPackage_id
       AND CC.CAUSAL_ID IN
           (dald_parameter.fnuGetNumeric_Value('PAR_C_SUSP_ACO_XNCAMMED', NULL)) -- causal 
       AND CC.CAUSAL_TYPE_ID IN
           (dald_parameter.fnuGetNumeric_Value('PAR_TC_SUSP_CDM', NULL)); -- tipo de causal      


  BEGIN

	pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);

    -- Consultamos datos para inicializar el proceso
    /*LOGICA: Validar el tipo de causal y la causal con la que se registró la solicitud, además validará el tipo de solicitud*/
    --causal y tipo causal de la solicitud
	IF (cuCausal%ISOPEN) THEN
        CLOSE cuCausal;
    END IF;

	OPEN cuCausal;
    FETCH cuCausal INTO nu_causal;
    CLOSE cuCausal;

    --tipo de solicitud
	IF (cuTipoSolicitud%ISOPEN) THEN
        CLOSE cuTipoSolicitud;
    END IF;

	OPEN cuTipoSolicitud;
    FETCH cuTipoSolicitud INTO nu_tiposol;
    CLOSE cuTipoSolicitud;

	IF (cuCausalNoCamMed%ISOPEN) THEN
        CLOSE cuCausalNoCamMed;
    END IF;

	OPEN cuCausalNoCamMed;
    FETCH cuCausalNoCamMed INTO nu_causalnocambed;
    CLOSE cuCausalNoCamMed;

    --causal y tipo causal de la solicitud
	IF (cuCausalSolicitud%ISOPEN) THEN
        CLOSE cuCausalSolicitud;
    END IF;

	OPEN cuCausalSolicitud;
    FETCH cuCausalSolicitud INTO nu_causal_aco;
    CLOSE cuCausalSolicitud;

	IF (cuCausalNoCamMedAco%ISOPEN) THEN
        CLOSE cuCausalNoCamMedAco;
    END IF;

	OPEN cuCausalNoCamMedAco;
    FETCH cuCausalNoCamMedAco INTO nu_causalnocambed_aco;
    CLOSE cuCausalNoCamMedAco;          

    --valido las causales y tipo de causales
    IF nu_causal > 0 AND nu_tiposol > 0 THEN
      RETURN 1;
    ELSIF nu_causalnocambed>0 AND nu_tiposol > 0 THEN
      RETURN 2;
    ELSIF nu_causal_aco>0 AND nu_tiposol > 0 THEN
      RETURN 3;
    ELSIF nu_causalnocambed_aco>0 AND nu_tiposol > 0 THEN
      RETURN 4;
    ELSE
      RETURN 0;
    END IF;
	
	pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
	
  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.GetError(onuErrorCode, sbmensa);
      pkg_traza.trace(csbMT_NAME||' onuErrorCode'||onuErrorCode||':'||sbmensa, cnuNVLTRC);
	  pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
      RAISE;
    WHEN OTHERS THEN
      sbmensa := 'Proceso termino con Errores. ' || SQLERRM;
      Pkg_Error.SetError;
	  pkg_traza.trace(csbMT_NAME||' -'||sbmensa||SQLERRM, cnuNVLTRC, pkg_traza.csbFIN_ERC);
	  pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      RAISE pkg_Error.Controlled_Error;
  END pGestionaOrdenVMP;

    PROCEDURE pProcesaOrdNotifSusp IS
    /**************************************************************************
     Autor       : Daniel Valiente / Horbath
     Fecha       : 2020-12-23
     Ticket      : 263
     Proceso     : pProces
     HISTORIA DE MODIFICACIONESaOrdNotifSusp
     Descripcion : procedimiento para validar la creacion masiva de tramites de suspension

     FECHA        AUTOR         DESCRIPCION
     07/06/2023   jpinedc -MVM  OSF-1085: Se modifica cuOrdenes para 
                                * tener en cuenta la fecha de próxima revisón en ldc_vpm 
                                solo para el Tipo de trabajo 
                                11185 - VPM _ ENTREGA DE NOTIFICACION POR SUSPENSION X SEGURIDAD
                                * verificar que no haya registro de cancelación del proceso 
                                de suspensión por CLM en la  tabla LDC_LOG_PROCESO_VMP 
                                para Tipos de trabajo diferentes a 
                                11185 - VPM _ ENTREGA DE NOTIFICACION POR SUSPENSION X SEGURIDAD
     14/06/2023   jpinedc -MVM  OSF-1085: se crea pCargaParametros para cargar y
                                validar los parametros
     14/07/2023   jpinedc -MVM  OSF-1085: Se modifica cuOrdenes
    ***************************************************************************/
        onuErrorCode NUMBER;
        sbmensa      VARCHAR2(10000);
        sbmensa2     VARCHAR2(5000);
		
		csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.pProcesaOrdNotifSusp';


        -- Lista de tipos de trabajo y dias de legalización
        sbTiTrNotifSuspVMP  LD_PARAMETER.VALUE_CHAIN%TYPE;

        -- Lista de tipos de trabajo de notificación de suspensión por VPM
        sbTiTrVPMNotiSusp   LD_PARAMETER.VALUE_CHAIN%TYPE;

        -- Lista de tipos de trabajo de CLM
        sbTiTrProcAbierto   LD_PARAMETER.VALUE_CHAIN%TYPE;

        -- Lista de actividades de CLM - Calidad de la medición
        sbActivCLM          LD_PARAMETER.VALUE_CHAIN%TYPE;

        CURSOR cuTipoTrabajo IS
        SELECT SUBSTR(DatosParametro, 1, INSTR(DatosParametro, '=', 1, 1)-1 ) TipoTrabajo,
               SUBSTR(DatosParametro, INSTR(DatosParametro, '=', 1, 1) + 1, INSTR(DatosParametro, '=', 1, 2) -INSTR(DatosParametro, '=', 1, 1)-1 ) Tiempo,
               SUBSTR(DatosParametro, INSTR(DatosParametro, '=', 1, 2)+1) Causal
        FROM(
	       SELECT regexp_substr(sbTiTrNotifSuspVMP, '[^,]+', 1, LEVEL)AS DatosParametro
		    FROM dual
			CONNECT BY regexp_substr(sbTiTrNotifSuspVMP, '[^,]+', 1, LEVEL) IS NOT NULL); --DatosParametro 

        CURSOR cuOrdenes(inu_task_type_id NUMBER, inu_days NUMBER) IS
          SELECT oo.order_id, a.product_id, p.address_id
            FROM or_order oo, ge_causal gc, or_order_activity a, pr_product p
           WHERE INSTR( ',' || sbTiTrVPMNotiSusp || ',', ',' || inu_task_type_id || ',' ) > 0
             AND oo.order_id=a.order_id
             AND oo.task_type_id = inu_task_type_id
             AND oo.order_status_id = 8
             AND gc.causal_id = oo.causal_id
             AND gc.class_causal_id = 1
             AND pkg_bcordenes.fblObtenerEsNovedad(oo.order_id) ='N'
             AND ROUND(TRUNC(SYSDATE) - TRUNC(oo.legalization_date))>= inu_days
             AND p.product_id=a.product_id 
             AND p.product_status_id=1
             AND EXISTS(SELECT NULL FROM ldc_vpm v WHERE v.product_id=a.product_id AND v.fecha_proxima_vpm<=SYSDATE)
             AND NOT EXISTS ( SELECT '1' FROM LDC_LOG_PROCESO_VMP lp WHERE lp.producto = a.product_id AND lp.proceso = csbPluginCancSuspCLM AND lp.fecha_registro > oo.legalization_date )                       
            UNION ALL
          SELECT oo.order_id, a.product_id, p.address_id
            FROM or_order oo, ge_causal gc, or_order_activity a, pr_product p
           WHERE INSTR( ',' || sbTiTrVPMNotiSusp || ',', ',' || inu_task_type_id || ',' ) = 0
             AND oo.order_id=a.order_id
             AND oo.task_type_id = inu_task_type_id
             AND oo.order_status_id = 8
             AND gc.causal_id = oo.causal_id
             AND gc.class_causal_id = 1
		     AND pkg_bcordenes.fblObtenerEsNovedad(oo.order_id) ='N'
             AND ROUND(TRUNC(SYSDATE) - TRUNC(oo.legalization_date))>= inu_days
             AND p.product_id=a.product_id 
             AND p.product_status_id=1
             AND NOT EXISTS ( SELECT '1' FROM LDC_LOG_PROCESO_VMP lp WHERE lp.producto = a.product_id AND lp.proceso = csbPluginCancSuspCLM AND lp.fecha_registro > oo.legalization_date ) 
             ;         
        CURSOR cuOrdenAsignar IS
        SELECT v.rowid, v.solicitud, o.order_id, o.order_status_id, v.unidad_trabajo
        FROM LDC_LOG_PROCESO_VMP v
        INNER JOIN or_order_activity a ON a.package_id=v.solicitud
        INNER JOIN or_order o ON o.order_id=a.order_id AND o.order_status_id=0
        WHERE v.proceso='pProcesaOrdNotifSusp_ASIGNA'
          AND v.procesado ='N'
          AND v.unidad_trabajo IS NOT NULL;

        CURSOR cuContador(inuProducto pr_product.product_id%TYPE,
                          inuOrden or_order.order_id%TYPE,
                          isbTitrNotif ld_parameter.value_chain%TYPE) IS
        SELECT COUNT(*)
        FROM or_order oo1
        WHERE oo1.order_status_id=8
        AND oo1.legalization_date IN
           (SELECT MAX(oo.legalization_date)
            FROM or_order oo, ge_causal gc, or_order_activity ooa
            WHERE oo.causal_id = gc.causal_id
            AND ooa.order_id = oo.order_id
            AND oo.order_status_id = 8
            AND gc.class_causal_id  = 1
            AND ooa.product_id IN (inuProducto)
            AND pkg_bcordenes.fblObtenerEsNovedad(oo.order_id)='N'
            AND INSTR(isbTitrNotif,oo.task_type_id||'=')>0
           )
        AND oo1.order_id = inuOrden;

		nuContador         NUMBER;

		CURSOR cuCantOrdAbiertas(inuProducto pr_product.product_id%TYPE,
		                         isbTiTrProcAbierto VARCHAR2) IS
        SELECT COUNT(*)
        FROM or_order_activity ooa, or_order oo
        WHERE ooa.product_id = inuProducto
        AND oo.order_id = ooa.order_id
        AND oo.task_type_id IN
                             (
                               SELECT to_number(regexp_substr(isbTiTrProcAbierto,
                                                      '[^,]+',
                                                      1,
                                                      LEVEL)) AS tipo_trab
                               FROM dual
                               CONNECT BY regexp_substr(isbTiTrProcAbierto, '[^,]+', 1, LEVEL)IS NOT NULL
							 )
        AND oo.order_status_id IN (0, 1, 5, 6, 7, 11, 20);

		CURSOR cuClienteOrden(inuOrden or_order.order_id%TYPE) IS
		SELECT s.subscriber_id
        FROM or_order o, ge_subscriber s
        WHERE o.subscriber_id = s.subscriber_id
        AND o.order_id = inuOrden;

        CURSOR cuUniOperProducto(inuproducto pr_product.product_id%TYPE,
								 isbActivCLM  VARCHAR2) IS
		SELECT oo.operating_unit_id
                            FROM 
                            (
                                SELECT oo1.order_id, oo1.operating_unit_id, oo1.legalization_date
                                FROM or_order          oo1,
                                         ge_causal         gc1,
                                         or_order_activity oa1,
                                         mo_packages       mp1
                                WHERE oa1.product_id = inuproducto
                                AND oa1.activity_id IN
                                                     (
	                                                  SELECT regexp_substr(isbActivCLM, '[^,]+', 1, LEVEL)AS DatosParametro
		                                              FROM dual
			                                          CONNECT BY regexp_substr(isbActivCLM, '[^,]+', 1, LEVEL) IS NOT NULL
								                      )
									 AND oo1.order_status_id IN (8)
                                     AND gc1.causal_id = oo1.causal_id
                                     AND oa1.order_id = oo1.order_id
                                     AND oa1.PACKAGE_ID = mp1.PACKAGE_ID
                                     AND mp1.PACKAGE_TYPE_ID = 100101
                                   ORDER BY oo1.legalization_Date DESC
                            ) oo
                            WHERE ROWNUM=1;


        --variables tramite
        sbRequestXML      constants_per.tipo_xml_sol%TYPE;
        nuPackageId       mo_packages.package_id%TYPE;
        nuMotiveId        mo_motive.motive_id%TYPE;
        comentario        varchar2(2000);
        nusubscriber_id   NUMBER;
        nuoperatingunitid NUMBER;
        nuRecepcion       ld_parameter.numeric_value%TYPE ;
        nuTiposuspen      ld_parameter.numeric_value%TYPE ;
        nuTipoCausal      ld_parameter.numeric_value%TYPE ;
        sbTitrNotif       ld_parameter.value_chain%TYPE   ;

        nuError           NUMBER;
        sbError           varchar2(4000);

        blUltOrdLegEsCLM        BOOLEAN;
        nuCantOrdCLMAbiertas    NUMBER;
        blCreaTramSuspCLM       BOOLEAN;
		sbProceso				VARCHAR2(70) := 'pProcesaOrdNotifSusp'||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');

        PROCEDURE pCargaParametros
        IS
        BEGIN
			
			pkg_traza.trace('Inicia '||csbMT_NAME||'.pCargaParametros',cnuNVLTRC);

            sbTiTrNotifSuspVMP  :=  dald_parameter.fsbgetvalue_chain('LDC_TT_NOTIF_SUSP_VMP', cnuVAL_EXIS_PARAM);
            sbTiTrVPMNotiSusp   :=  dald_parameter.fsbGetValue_Chain('TITR_VPM_NOTI_SUSP',cnuVAL_EXIS_PARAM);
            nuRecepcion         :=  dald_parameter.fnuGetNumeric_Value('PAR_RECEPTYPEID_CDM',cnuVAL_EXIS_PARAM);
            nuTiposuspen        :=  dald_parameter.fnuGetNumeric_Value('PAR_TIPOSUSP_CDM',cnuVAL_EXIS_PARAM);
            nuTipoCausal        :=  dald_parameter.fnuGetNumeric_Value('PAR_TC_SUSP_CDM',cnuVAL_EXIS_PARAM);
            sbTitrNotif         :=  dald_parameter.fsbGetValue_Chain('LDC_TT_NOTIF_SUSP_VMP',cnuVAL_EXIS_PARAM);
            sbTiTrProcAbierto   :=  dald_parameter.fsbgetvalue_chain('LDC_TT_PROCESO_ABIERTO', cnuVAL_EXIS_PARAM );
            sbActivCLM          :=  dald_parameter.fsbgetvalue_chain('ACTIVIDADES_CALIDAD_MEDICION',cnuVAL_EXIS_PARAM);

            pkg_traza.trace('Termina '||csbMT_NAME||'.pCargaParametros',cnuNVLTRC);

        END pCargaParametros;

    BEGIN

		pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);

        pCargaParametros;

	    pkg_estaproc.prInsertaEstaproc(
		                               sbProceso,
									   NULL
									  );


        /*LOGICA: Este servicio tomará todas las órdenes de los tipos de trabajo configurados en el parámetro LDC_TT_NOTIF_SUSP_VMP, que se encuentren legalizados con causal de éxito (ge_causal.class_causal_id = 1) y que entre la fecha de legalización y la fecha de ejecución del servicio (SYSDATE) hayan pasado el número de días definido en el dicho parámetro*/
        FOR tempcuTipoTrabajo IN cuTipoTrabajo LOOP

            IF cuOrdenes%ISOPEN THEN
                CLOSE cuOrdenes;
            END IF;

            FOR tempcuOrdenes IN cuOrdenes(tempcuTipoTrabajo.Tipotrabajo,
                                           tempcuTipoTrabajo.Tiempo) LOOP
            BEGIN
                /* y por cada orden realizará lo siguiente:*/
                /*¿ Validará que el producto se encuentre en estado 1 ¿ Activo.*/
                blUltOrdLegEsCLM := FALSE;

                /*¿ Validará que dicha orden sea la última orden legalizada con éxito para el producto.*/

                nuContador := 0;

			    IF (cuContador%ISOPEN) THEN
                CLOSE cuContador;
                END IF;

                OPEN cuContador(tempcuOrdenes.product_id, tempcuOrdenes.order_id,sbTitrNotif);
                FETCH cuContador INTO nuContador;
                CLOSE cuContador;

                IF nuContador > 0 THEN
                    blUltOrdLegEsCLM := TRUE;
                END IF;

                /*¿ Validará que el producto no tenga una orden abierta del tipo de trabajo perteneciente al parámetro LDC_TT_PROCESO_ABIERTO.*/
                IF blUltOrdLegEsCLM THEN
                    blCreaTramSuspCLM := TRUE;
                    nuCantOrdCLMAbiertas := 0;

			        IF (cuCantOrdAbiertas%ISOPEN) THEN
                     CLOSE cuCantOrdAbiertas;
                    END IF;

                    OPEN cuCantOrdAbiertas(tempcuOrdenes.product_id,sbTiTrProcAbierto);
                    FETCH cuCantOrdAbiertas INTO nuCantOrdCLMAbiertas;
                    CLOSE cuCantOrdAbiertas;

                    IF nuCantOrdCLMAbiertas > 0 THEN
                        blCreaTramSuspCLM := FALSE;
                    END IF;

                END IF;
                /*¿ Validará que la fecha de revisión VMP no esté vigente.*/
                IF blCreaTramSuspCLM THEN
                    /*¿ Si cumple las validaciones anteriores, se creará el trámite Suspensión por calidad de medición con el tipo de causal XX ¿ SUSPENSIÓN POR CALIDAD DE LA MEDICIÓN CDM y con la causal XXX ¿ SUSPENSIÓN POR CALIDAD DE LA MEDICIÓN CDM, generando así una orden de tipo de trabajo AAAA: Suspensión por CDM ¿ Calidad de la medición. */

					IF (cuClienteOrden%ISOPEN) THEN
                     CLOSE cuClienteOrden;
                    END IF;

                    OPEN cuClienteOrden(tempcuOrdenes.Order_Id);
                    FETCH cuClienteOrden INTO nusubscriber_id;
                    CLOSE cuClienteOrden;


                    comentario:='Registrado por Job de suspension de Calidad de Medicion';

                    sbRequestXML := PKG_XML_SOLI_CALID_MEDIC.getSolicitudSuspensionCLM(nuRecepcion,
					                                                                   comentario,
																					   tempcuOrdenes.product_id,
																					   nusubscriber_id,
																					   nuTiposuspen,
																					   nuTipoCausal,
																					   tempcuTipoTrabajo.causal);

                    Api_RegisterRequestByXML(sbRequestXML,
                                            nuPackageId,
                                            nuMotiveId,
                                            onuErrorCode,
                                            sbmensa);

                    IF onuErrorCode <> 0 THEN
                        RAISE pkg_Error.Controlled_Error;
                    ELSE
                        COMMIT;
                        /*¿ Una vez generada la orden, se buscará la última orden que pertenezca al tipo de trabajo del parámetro LDC_TT_GEN_NOTIFICACION, legalizada con causal de fallo, asociada a un trámite de VSI y de ahí se obtendrá la unidad de trabajo y a esa se asignará la orden de trabajo. Para asignar la orden se hará uso del API os_assign_order. En caso de que el proceso de asignación falle, se almacenará el error en una tabla de log de errores (LDC_LOG_PROCESO_VMP)
                        */

                        BEGIN

						  IF (cuUniOperProducto%ISOPEN) THEN
                           CLOSE cuUniOperProducto;
                          END IF;

                          OPEN cuUniOperProducto(tempcuOrdenes.product_id,sbActivCLM);
                          FETCH cuUniOperProducto INTO nuoperatingunitid;
							IF cuUniOperProducto%NOTFOUND THEN
								CLOSE cuUniOperProducto;
						        RAISE NO_DATA_FOUND;
							END IF;
                          CLOSE cuUniOperProducto;

                        EXCEPTION
                            WHEN NO_DATA_FOUND THEN
                                nuoperatingunitid := NULL;
                                sbmensa2          := 'No se pudo establecer una Unidad Operativa para el Producto ' ||
                                                     tempcuOrdenes.product_id;
                                onuErrorCode      := -1;

                            WHEN OTHERS THEN
                                nuoperatingunitid := NULL;
                                sbmensa2          := 'Otros: No se pudo establecer una Unidad Operativa para el Producto ' ||
                                                     tempcuOrdenes.product_id;
                                onuErrorCode      := -1;
                        END;

                        IF nuoperatingunitid IS NOT NULL THEN
                            INSERT INTO LDC_LOG_PROCESO_VMP(LOG_PROCESO_VMP_ID,PRODUCTO,SOLICITUD ,UNIDAD_TRABAJO,  FECHA_REGISTRO,MENSAJE_ERROR, proceso,PROCESADO) values(SEQ_LDC_LOG_PROCESO_VMP.NEXTVAL,tempcuOrdenes.product_id,nuPackageId,nuoperatingunitid, SYSDATE, NULL,'pProcesaOrdNotifSusp_ASIGNA','N');
                            COMMIT;
                        ELSE
                            INSERT INTO LDC_LOG_PROCESO_VMP(LOG_PROCESO_VMP_ID,PRODUCTO,SOLICITUD ,UNIDAD_TRABAJO,  FECHA_REGISTRO,MENSAJE_ERROR, proceso,PROCESADO) values(SEQ_LDC_LOG_PROCESO_VMP.NEXTVAL,tempcuOrdenes.product_id,nuPackageId,nuoperatingunitid, SYSDATE,sbmensa2,'pProcesaOrdNotifSusp_ASIGNA','S');
                            COMMIT;
                        END IF;

                    END IF;
                END IF;
                EXCEPTION
                WHEN pkg_Error.Controlled_Error THEN
                     ROLLBACK;
                     pkg_Error.GetError(onuErrorCode, sbmensa);             
                     INSERT INTO LDC_LOG_PROCESO_VMP(LOG_PROCESO_VMP_ID,PRODUCTO,FECHA_REGISTRO,MENSAJE_ERROR, proceso, PROCESADO) values(SEQ_LDC_LOG_PROCESO_VMP.NEXTVAL,tempcuOrdenes.product_id, SYSDATE,'Error al Generar tramite: '||sbmensa,'pProcesaOrdNotifSusp_GENERA','S');
                     COMMIT;
                WHEN OTHERS THEN
                   ROLLBACK;
                   Pkg_Error.SetError;
                   pkg_Error.GetError(onuErrorCode, sbmensa);
                  INSERT INTO LDC_LOG_PROCESO_VMP(LOG_PROCESO_VMP_ID,PRODUCTO,FECHA_REGISTRO,MENSAJE_ERROR, proceso,PROCESADO) values(SEQ_LDC_LOG_PROCESO_VMP.NEXTVAL,tempcuOrdenes.product_id, SYSDATE,'Error al Generar tramite: '||sbmensa,'pProcesaOrdNotifSusp_GENERA','S');
                  COMMIT;
                END;

            END LOOP;

        END LOOP;

        DBMS_LOCK.SLEEP(10);

        FOR reg IN cuOrdenAsignar LOOP 
            nuError := 0;
            sbError := NULL;
            BEGIN
                API_ASSIGN_ORDER(reg.order_id,
                         reg.unidad_trabajo,
                         nuError,
                         sbError);

                IF nuError = 0 THEN
                    UPDATE LDC_LOG_PROCESO_VMP r
                    SET r.PROCESADO='S'
                    WHERE r.rowid=reg.rowid;
                    COMMIT;
                 ELSE
                    ROLLBACK;
                    UPDATE LDC_LOG_PROCESO_VMP r
                    SET r.mensaje_error=sbError
                    WHERE r.rowid=reg.rowid;
                    COMMIT;
                 END IF;

            EXCEPTION 
                WHEN pkg_Error.Controlled_Error THEN
                    ROLLBACK;
                    pkg_Error.GetError(onuErrorCode, sbmensa);
                    UPDATE LDC_LOG_PROCESO_VMP r
                    SET r.mensaje_error=sbmensa
                    WHERE r.rowid=reg.rowid;
                    COMMIT;
                WHEN others THEN
                    ROLLBACK;
                    pkg_Error.GetError(onuErrorCode, sbmensa);
                    UPDATE LDC_LOG_PROCESO_VMP r
                    SET r.mensaje_error=sbmensa
                    WHERE r.rowid=reg.rowid;
                    COMMIT;
            END;
        END LOOP;

        --finalizamos el proceso

		pkg_estaproc.prActualizaEstaproc(sbProceso,'Finalizado','Ok');

		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
        

    EXCEPTION
        WHEN pkg_Error.Controlled_Error THEN
             pkg_Error.GetError(onuErrorCode, sbmensa);
			 pkg_estaproc.prActualizaEstaproc(sbProceso,'Error',sbmensa);
			 pkg_traza.trace(csbMT_NAME||' -'||sbmensa, cnuNVLTRC);
			 pkg_traza.trace(csbMT_NAME,cnuNVLTRC,pkg_traza.csbFIN_ERC);
        WHEN OTHERS THEN
             sbmensa := 'Proceso termino con Errores. ' || SQLERRM;
             pkg_estaproc.prActualizaEstaproc(sbProceso,'Error',sbmensa);
			 pkg_traza.trace(csbMT_NAME||' -'||sbmensa||' '||SQLERRM, cnuNVLTRC, pkg_traza.csbFIN_ERR);
			 pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
    END pProcesaOrdNotifSusp;

  PROCEDURE pProcesaOrdSuspCalimed IS
    /**************************************************************************
     Autor       : Daniel Valiente / Horbath
     Fecha       : 2020-12-23
     Ticket      : 263
     Proceso     : pProcesaOrdSuspCalimed
     Descripcion : procedimiento para validar la creacion masiva de tramites de suspension por calidad de medicion

     HISTORIA DE MODIFICACIONES
     FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    onuErrorCode NUMBER;
    sbmensa      VARCHAR2(10000);
    nuTipoSup    ld_parameter.numeric_value%TYPE:= dald_parameter.fnuGetNumeric_Value('PAR_TIPOSUSP_CDM',NULL);
    sbUltTitr    ld_parameter.value_chain%TYPE:=dald_parameter.fsbgetvalue_chain('PAR_ULT_TITR_VAL_GEST',NULL);
    nuMedioRecepcion ld_parameter.numeric_value%TYPE := dald_parameter.fnugetnumeric_value('LDC_MED_REC_VSI_USU_SUSP',NULL);
    producto_id      NUMBER;
    contador         NUMBER;
    sw_valida        NUMBER := 1;
    sbRequestXML     constants_per.tipo_xml_sol%type;
    nuPersonIdsol    ge_person.person_id%TYPE := pkg_bopersonal.fnuGetPersonaId;
    nuPtoAtncndsol   ge_organizat_area.organizat_area_id%TYPE;

    actVSI           ge_items.items_id%TYPE;
    actVSIXNoCambio  ld_parameter.numeric_value%TYPE := dald_parameter.fnuGetNumeric_Value('LDC_ACT_VSI_USU_SUSXNOCAMB',NULL);
    nuPackageId      mo_packages.package_id%TYPE;
    nuMotiveId       mo_motive.motive_id%TYPE;
    sbTtReconex      ld_parameter.value_chain%TYPE := dald_parameter.fsbgetvalue_chain('LDC_TT_RECON_ABIERTO',NULL);
    sbTtProceso      ld_parameter.value_chain%TYPE := dald_parameter.fsbgetvalue_chain('LDC_TT_PROCESO_ABIERTO',NULL);
	
	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.pProcesaOrdSuspCalimed';
	sbProceso 	VARCHAR2(70) := 'pProcesaOrdSuspCalimed'||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');

    CURSOR cuOrdenes IS
      SELECT P.PRODUCT_ID, P.ADDRESS_ID, P.SUBSCRIPTION_ID contrato, SU.SUSCCLIE
      FROM PR_PRODUCT P
      INNER JOIN PR_PROD_SUSPENSION S ON S.PRODUCT_ID=P.PRODUCT_ID AND S.ACTIVE='Y' AND S.SUSPENSION_TYPE_ID=106
      INNER JOIN SUSCRIPC SU ON SU.SUSCCODI=P.SUBSCRIPTION_ID
      WHERE PRODUCT_STATUS_ID=2
        AND PRODUCT_TYPE_ID=pkg_parametros.fnuGetValorNumerico('SERVICIO_GAS_CLM')
        AND ldc_boprocesaordvmp.pvalidatiposuspension(p.product_id)='CM'
        AND EXISTS(SELECT NULL FROM ldc_vpm v WHERE v.product_id=p.product_id AND v.fecha_proxima_vpm<=SYSDATE);

    CURSOR CUULTOTVALI(NUPRODUCTO PR_PRODUCT.PRODUCT_ID%TYPE) IS
    SELECT O.ORDER_ID, O.LEGALIZATION_DATE, O.CAUSAL_ID, O.TASK_TYPE_ID
    FROM OR_ORDER O
    INNER JOIN OR_ORDER_ACTIVITY A ON A.ORDER_ID=O.ORDER_ID
    WHERE A.PRODUCT_ID = NUPRODUCTO
     AND O.ORDER_STATUS_ID = 8
     AND pkg_bcordenes.fblObtenerEsNovedad(o.order_id) = 'N'
     AND O.TASK_TYPE_ID IN (SELECT TITR FROM 
     (

     SELECT TO_NUMBER(SUBSTR(DatosParametro, 1, INSTR(DatosParametro, '|', 1) - 1)) titr,
       TO_NUMBER(SUBSTR(DatosParametro,
              INSTR(DatosParametro, '|', 1,1) + 1,
              INSTR(DatosParametro, '|', 1,2)  -INSTR(DatosParametro, '|', 1,1) -1)) causal,
       TO_NUMBER(SUBSTR(DatosParametro,
              INSTR(DatosParametro, '|', 1,2) + 1,
              INSTR(DatosParametro, '|', 1,3) + -INSTR(DatosParametro, '|', 1,2)-1 )) dias,
       TO_NUMBER(SUBSTR(DatosParametro,
              INSTR(DatosParametro, '|', 1,3) + 1)) actividad
  FROM (
        SELECT regexp_substr(sbUltTitr, '[^;]+', 1, LEVEL)AS DatosParametro
		FROM dual
		CONNECT BY regexp_substr(sbUltTitr, '[^;]+', 1, LEVEL) IS NOT NULL
        )

     ))
    ORDER BY O.LEGALIZATION_DATE DESC;

    CURSOR cuValidaCausal(nuTitr or_task_Type.task_type_id%TYPE,
                          nuCausal ge_causal.causal_id%TYPE) IS
	WITH base AS(
					   SELECT TO_NUMBER(SUBSTR(DatosParametro, 1, INSTR(DatosParametro, '|', 1) - 1)) titr,
					   TO_NUMBER(SUBSTR(DatosParametro,
							  INSTR(DatosParametro, '|', 1,1) + 1,
							  INSTR(DatosParametro, '|', 1,2)  -INSTR(DatosParametro, '|', 1,1) -1)) causal,
					   TO_NUMBER(SUBSTR(DatosParametro,
							  INSTR(DatosParametro, '|', 1,2) + 1,
							  INSTR(DatosParametro, '|', 1,3) + -INSTR(DatosParametro, '|', 1,2)-1 )) dias,
					   TO_NUMBER(SUBSTR(DatosParametro,
							  INSTR(DatosParametro, '|', 1,3) + 1)) actividad
					   FROM  (
							  SELECT regexp_substr(sbUltTitr, '[^;]+', 1, LEVEL)AS DatosParametro
							  FROM dual
							  CONNECT BY regexp_substr(sbUltTitr, '[^;]+', 1, LEVEL) IS NOT NULL
							 )
					) 
		SELECT *
		FROM base
		WHERE base.titr=nuTitr
		AND base.causal=nuCausal;

		CURSOR cuOrdenAbierta(inuProducto pr_product.product_id%TYPE,
							  isbTtReconex ld_parameter.value_chain%TYPE,
							  isbTtProceso ld_parameter.value_chain%TYPE
 							  )IS
		  SELECT COUNT(*)
			FROM or_order_activity ooa, or_order oo
		   WHERE ooa.product_id = inuProducto
			 AND oo.order_id = ooa.order_id
			 AND oo.task_type_id IN
				 (
				   SELECT to_number(regexp_substr(isbTtReconex,'[^,]+',1,LEVEL)) AS Tipo_Reco
									FROM dual
									CONNECT BY regexp_substr(isbTtReconex, '[^,]+', 1, LEVEL) IS NOT NULL
				  UNION ALL
				   SELECT to_number(regexp_substr(isbTtProceso,'[^,]+',1,LEVEL)) AS Tipo_Reco
									FROM dual
									CONNECT BY regexp_substr(isbTtProceso, '[^,]+', 1, LEVEL) IS NOT NULL
				 )
			 AND oo.order_status_id IN (0, 5, 6, 7,11 ,20);



  rgUltTitrVal     CUULTOTVALI%ROWTYPE;
  rgValCausal      cuValidaCausal%ROWTYPE;
  sbComentario     mo_packages.comment_%TYPE;

  BEGIN
    -- Inicializamos el proceso
	pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	
    pkg_estaproc.prInsertaEstaproc(sbProceso,NULL);
    nuPtoAtncndsol:= pkg_bopersonal.fnuGetPuntoAtencionId(nuPersonIdsol);	

    /*LOGICA: se encargará de tomar todas las órdenes de los tipos de trabajo configurados en el parámetro LDC_TT_SUSP_CALIMED_VMP, que se encuentren legalizados con causal de éxito (ge_causal.class_causal_id = 1) y que entre la fecha de legalización y la fecha de ejecución del servicio (SYSDATE) hayan pasado el número de días definido en el parámetro LDC_CANT_DIAS_SUSP*/

	FOR tempcuOrdenes IN cuOrdenes LOOP
      --Valida si la ultima orden es valida para generar el proceso
      sw_valida :=1;
      OPEN CUULTOTVALI(tempcuOrdenes.product_id);
      FETCH CUULTOTVALI INTO rgUltTitrVal;
      IF CUULTOTVALI%notfound THEN
         sw_valida := 0;
      ELSE
         OPEN cuValidaCausal(rgUltTitrVal.task_type_id, rgUltTitrVal.causal_id);
         FETCH cuValidaCausal INTO rgValCausal;
         IF cuValidaCausal%notfound THEN
           sw_valida := 0;
         ELSE
           IF TRUNC(SYSDATE)- TRUNC(rgUltTitrVal.legalization_Date)>=rgValCausal.dias THEN
             sw_valida := 1;
             actVSI := rgValCausal.actividad;
           ELSE
             sw_valida := 0;
           END IF;
         END IF;
         CLOSE cuValidaCausal;
      END IF;
      CLOSE CUULTOTVALI;
      IF sw_valida = 1 THEN
        BEGIN
            /*¿ Validará que el producto no tenga una orden abierta del tipo de trabajo perteneciente al parámetro LDC_TT_RECON_ABIERTO*/
              sw_valida := 1;
              contador := 0;

			  IF cuOrdenAbierta%ISOPEN THEN
				  CLOSE cuOrdenAbierta;
			  END IF;
			  
			  OPEN cuOrdenAbierta(tempcuOrdenes.product_id, sbTtReconex,sbTtProceso);
			  FETCH cuOrdenAbierta INTO contador;
			  CLOSE cuOrdenAbierta;

              IF contador > 0 THEN
                sw_valida := 0;
              END IF;

              IF sw_valida = 1 THEN
                /*¿ Si cumple las validaciones anteriores se creará un trámite de venta de servicios de ingeniería con la actividad almacenada 
                ¿ Este trámite será creado con medio de recepción del parámetro LDC_MED_REC_VSI_USU_SUSP.
                ¿ El comentario de creación será: GESTIÓN USUARIOS SUSPENDIDOS POR VPM.
                */

				sbComentario:= 'GESTIÓN USUARIOS SUSPENDIDOS POR VPM';

                sbRequestXML := pkg_xml_soli_vsi.getSolicitudVSI(tempcuOrdenes.contrato,
																 nuMedioRecepcion,
																 sbComentario,
																 tempcuOrdenes.product_id,
																 tempcuOrdenes.suscclie,	
																 nuPersonIdsol,
																 nuPtoAtncndsol,
																 SYSDATE,
																 tempcuOrdenes.address_id,
																 tempcuOrdenes.address_id,
																 actVSI
																);

                Api_RegisterRequestByXML(sbRequestXML,
                                          nuPackageId,
                                          nuMotiveId,
                                          onuErrorCode,
                                          sbmensa);

                IF nupackageid IS NULL THEN
                  RAISE pkg_Error.Controlled_Error;
                ELSE
                  COMMIT;
                END IF;

              END IF;
        EXCEPTION 
           WHEN pkg_Error.Controlled_Error THEN
                 ROLLBACK;
                 pkg_Error.GetError(onuErrorCode, sbmensa);             
                 INSERT INTO LDC_LOG_PROCESO_VMP(LOG_PROCESO_VMP_ID,PRODUCTO,FECHA_REGISTRO,MENSAJE_ERROR, proceso, PROCESADO) values(SEQ_LDC_LOG_PROCESO_VMP.NEXTVAL,tempcuOrdenes.product_id, SYSDATE,'Error al Generar tramite: '||sbmensa,'pProcesaOrdSuspCalimed_GENERA','S');
                 COMMIT;
            WHEN others THEN
               ROLLBACK;
               Pkg_Error.SetError;
               pkg_Error.GetError(onuErrorCode, sbmensa);
              INSERT INTO LDC_LOG_PROCESO_VMP(LOG_PROCESO_VMP_ID,PRODUCTO,FECHA_REGISTRO,MENSAJE_ERROR, proceso,PROCESADO) values(SEQ_LDC_LOG_PROCESO_VMP.NEXTVAL,tempcuOrdenes.product_id, SYSDATE,'Error al Generar tramite: '||sbmensa,'pProcesaOrdSuspCalimed_GENERA','S');
              COMMIT;
         END;
     END IF;
    END LOOP;
    --finalizamos el proceso
	pkg_estaproc.prActualizaEstaproc(sbProceso,'Finalizado','Ok');
	
	pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.GetError(onuErrorCode, sbmensa);
	  pkg_estaproc.prActualizaEstaproc(sbProceso,'Error',sbmensa);
	  pkg_traza.trace(csbMT_NAME||' Error: '||sbmensa, cnuNVLTRC);
	  pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
      RAISE;
    WHEN OTHERS THEN
      sbmensa := 'Proceso termino con Errores. ' || SQLERRM;
	  pkg_estaproc.prActualizaEstaproc(sbProceso,'Error',sbmensa);
      pkg_Error.SetError;
	  pkg_traza.trace(csbMT_NAME||' '||sbmensa||' :'||SQLERRM, cnuNVLTRC);
	  pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      RAISE pkg_Error.Controlled_Error;
  END pProcesaOrdSuspCalimed;

  PROCEDURE pGenVSI_UsuAutoriza IS
    /**************************************************************************
     Autor       : Daniel Valiente / Horbath
     Fecha       : 2020-12-23
     Ticket      : 263
     Proceso     : pGenVSI_UsuAutoriza 
     Descripcion : procedimiento para generar VSI de productos suspendidos

     HISTORIA DE MODIFICACIONES
     FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    onuErrorCode NUMBER;
    sbmensa      VARCHAR2(4000);
    nuorden          or_order.order_id%TYPE;
    nuproduct_id     pr_product.product_id%TYPE;
    nuPersonIdsol    ge_person.person_id%TYPE := pkg_bopersonal.fnuGetPersonaId;
    nuMedioRecepcion ld_parameter.numeric_value%TYPE := dald_parameter.fnugetnumeric_value('LDC_MED_REC_VSI_USU_SUSP',NULL);
    inuIdAddress     ab_address.address_id%TYPE;
    inuContactId     suscripc.suscclie%TYPE;
    actVSI           ge_items.items_id%TYPE;
    nuPtoAtncndsol   ge_organizat_area.organizat_area_id%TYPE;
    sbRequestXML     constants_per.tipo_xml_sol%TYPE;
    nuPackageId      mo_packages.package_id%TYPE;
    nuMotiveId       mo_motive.motive_id%TYPE;
    nuContrato       suscripc.susccodi%TYPE;
    nuCausal         ge_causal.causal_id%TYPE;
    nuUnidad         or_operating_unit.operating_unit_id%TYPE;
	sbComentario     mo_packages.comment_%TYPE;
	
	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.pGenVSI_UsuAutoriza';

	CURSOR cuDatosOrden(inuOrden or_order.order_id%TYPE) IS
	SELECT oa.product_id, p.address_id, s.suscclie, susccodi, o.causal_id
      FROM or_order_activity oa, pr_product p, suscripc s, or_order o
     WHERE oa.order_id = inuOrden
       AND p.product_id=oa.product_id
       AND s.susccodi=p.subscription_id
       AND o.order_id=oa.order_id;

	CURSOR cuActVSI(inuProducto pr_product.product_id%TYPE) IS
	    SELECT oa.activity_id, oa.operating_unit_id
        FROM (SELECT oo1.order_id, oo1.operating_unit_id, oo1.legalization_Date, oa1.activity_id
                FROM or_order oo1, ge_causal gc1, or_order_activity oa1
               WHERE oa1.product_id = inuProducto
                 AND oo1.task_type_id IN
									(
                                     SELECT to_number(regexp_substr(dald_parameter.fsbgetvalue_chain('LDC_TT_GEN_NOTIFICACION',NULL),
                                                                    '[^,]+',
                                                                    1,
                                                                    LEVEL)) AS tipo_trab
                                     FROM dual
                                     CONNECT BY regexp_substr(dald_parameter.fsbgetvalue_chain('LDC_TT_GEN_NOTIFICACION',NULL), '[^,]+', 1, LEVEL) IS NOT NULL
									)
                 AND oo1.order_status_id IN (8)
                 AND gc1.causal_id = oo1.causal_id
                 AND gc1.class_causal_id = 1
                    ---novedad
                 AND oa1.order_activity_id NOT IN
                     (SELECT n.items_id FROM CT_ITEM_NOVELTY n)
                 AND oa1.order_id = oo1.order_id
                 ORDER BY oo1.legalization_date desc) oa
      WHERE rownum=1;


  BEGIN
  
	pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);

    /*LOGICA: Crear? un tr?mite de venta de servicios de ingenier?a con la actividad de reconexi?n correspondiente a la actividad que suspendi? el producto, es decir, buscar? la ?ltima orden legalizada con causal de ?xito, que no sea novedad y que el tipo de trabajo se encuentre configurado en el par?metro LDC_TT_GEN_NOTIFICACION.*/

    nuOrden:= pkg_bcordenes.fnuObtenerOTInstanciaLegal; --se obtiene orden que se esta legalizando


    BEGIN
          IF (cuDatosOrden%ISOPEN) THEN
              CLOSE cuDatosOrden;
          END IF;

		  OPEN cuDatosOrden(nuOrden);
          FETCH cuDatosOrden INTO nuproduct_id,  inuIdAddress, inuContactId, nuContrato, nuCausal;
		  IF cuDatosOrden%NOTFOUND THEN
			CLOSE cuDatosOrden;
			RAISE NO_DATA_FOUND;
		  END IF;
          CLOSE cuDatosOrden;

    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        Pkg_Error.SetErrorMessage(PKG_ERROR.CNUGENERIC_MESSAGE, 'No se encontro informacion de la orden');
        RAISE pkg_Error.Controlled_Error;
      WHEN others THEN
        Pkg_Error.SetErrorMessage(PKG_ERROR.CNUGENERIC_MESSAGE, 'Otros: No se encontro informacion de la orden');
        RAISE pkg_Error.Controlled_Error;
    END;

    pkg_traza.trace('pGenVSI_UsuAutoriza-->nuproduct_id'||nuproduct_id,cnuNVLTRC);   
    pkg_traza.trace('pGenVSI_UsuAutoriza-->inuIdAddress'||inuIdAddress,cnuNVLTRC);
    pkg_traza.trace('pGenVSI_UsuAutoriza-->inuContactId'||inuContactId,cnuNVLTRC);
    pkg_traza.trace('pGenVSI_UsuAutoriza-->nuContrato'||nuContrato,cnuNVLTRC);

    BEGIN

	    IF (cuActVSI%ISOPEN) THEN
            CLOSE cuActVSI;
        END IF;

		OPEN cuActVSI(nuproduct_id);
        FETCH cuActVSI INTO actVSI,  nuUnidad;
		IF cuActVSI%NOTFOUND THEN
			CLOSE cuActVSI;
			RAISE NO_DATA_FOUND;
		END IF;
        CLOSE cuActVSI;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        sbmensa := 'No hay una actividad para generar la VSI';
        Pkg_Error.SetErrorMessage(PKG_ERROR.CNUGENERIC_MESSAGE, sbmensa);
        RAISE pkg_Error.Controlled_Error;
	  WHEN OTHERS THEN
        sbmensa := 'Otros: No hay una actividad para generar la VSI';
        Pkg_Error.SetErrorMessage(PKG_ERROR.CNUGENERIC_MESSAGE, sbmensa);
        RAISE pkg_Error.Controlled_Error;
    END;

    pkg_traza.trace('pGenVSI_UsuAutoriza-->actVSI'||actVSI,cnuNVLTRC);

	sbComentario:= 'GESTI?N USUARIOS SUSPENDIDOS POR VPM';

	nuPtoAtncndsol:= pkg_bopersonal.fnuGetPuntoAtencionId(nuPersonIdsol);

	sbRequestXML:=  pkg_xml_soli_vsi.getSolicitudVSI(nuContrato,
													 nuMedioRecepcion,
													 sbComentario,
													 nuproduct_id,
													 inuContactId,	
													 nuPersonIdsol,
													 nuPtoAtncndsol,
													 SYSDATE,
													 inuIdAddress,
													 inuIdAddress,
													 actVSI
													);


    pkg_traza.trace('pGenVSI_UsuAutoriza-->sbRequestXML'||sbRequestXML,cnuNVLTRC);                     
    Api_RegisterRequestByXML(sbRequestXML,
                              nuPackageId,
                              nuMotiveId,
                              onuErrorCode,
                              sbmensa);

    IF nupackageid IS NULL THEN
      sbmensa := 'No se pudo generar la Solicitud VSI'||sbmensa;
      RAISE pkg_Error.Controlled_Error;
    ELSE
      INSERT INTO LDC_ORDEASIGPROC
            (ORAPORPA,
             ORAPSOGE,
             ORAOPELE,
             ORAOUNID,
             ORAOCALE,
             ORAOITEM,
             ORAOPROC)
          VALUES
            (nuorden,
             nuPackageId,
             NULL,
             nuUnidad,
             nuCausal,
             NULL,
             'SEVAASAU');
    END IF;
	
	pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
	pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
     RAISE;
    WHEN OTHERS THEN
      sbmensa := 'Proceso termino con Errores. ' || SQLERRM;
      Pkg_Error.SetError;
	  pkg_traza.trace(csbMT_NAME||' '||sbmensa, cnuNVLTRC);
	  pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      RAISE pkg_Error.Controlled_Error;
  END pGenVSI_UsuAutoriza;

  PROCEDURE pGenSusp_UsuNoAutoriza IS
    /**************************************************************************
     Autor       : Daniel Valiente / Horbath
     Fecha       : 2020-12-23
     Ticket      : 263
     Proceso     : pGenVSI_UsuAutoriza 
     Descripcion : procedimiento para generar ordenes sobre productos suspendidos

     HISTORIA DE MODIFICACIONES
     FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    onuErrorCode    NUMBER;
    sbmensa         VARCHAR2(10000);
    osbErrorMessage VARCHAR2(10000);
    nuactivity   NUMBER := dald_parameter.fnugetnumeric_value('LDC_ACT_SUSP_ACOME_CALIMED',NULL);
    nuproduct_id pr_product.product_id%TYPE;
    nuorden      or_order.order_id%TYPE;
    nuaddress    ab_address.address_id%TYPE;
    nuOrderval   or_order.order_id%TYPE;
    nuNewOrderActivityId  or_order_activity.order_activity_id%TYPE;
    inuIdAddress     ab_address.address_id%TYPE;
    inuContactId     suscripc.suscclie%TYPE;
    nuContrato       suscripc.susccodi%TYPE;

	CURSOR cuDatosOrden(inuOrden or_order.order_id%TYPE)IS
     SELECT oa.product_id, p.address_id, s.suscclie, susccodi
      FROM or_order_activity oa, pr_product p, suscripc s
     WHERE oa.order_id = inuorden
       AND p.product_id=oa.product_id
       AND s.susccodi=p.subscription_id;
	
	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.pGenSusp_UsuNoAutoriza';
	
  BEGIN
  
	pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);

    /*LOGICA: Registrará una orden asociada al producto y tendrá la actividad configurada en el parámetro ¿LDC_ACT_SUSP_ACOME_CALIMED¿. Esta orden no estará asociada a un trámite o flujo, dado que en este punto el producto ya se encuentra suspendido.*/
    nuorden := or_bolegalizeorder.fnuGetCurrentOrder; --se obtiene orden que se esta legalizando
    BEGIN

	IF cuDatosOrden%ISOPEN THEN
		CLOSE cuDatosOrden;
	END IF;

	OPEN cuDatosOrden(nuorden);
	FETCH cuDatosOrden INTO nuproduct_id, inuIdAddress,inuContactId,nuContrato;
	IF cuDatosOrden%NOTFOUND THEN
		CLOSE cuDatosOrden;
		RAISE no_data_found;
	END IF;
	CLOSE cuDatosOrden;
	
    EXCEPTION
      WHEN no_data_found THEN
        Pkg_Error.SetErrorMessage(PKG_ERROR.CNUGENERIC_MESSAGE, 'No se encontro informacion de la orden');
        RAISE pkg_Error.Controlled_Error;
      WHEN others THEN
        Pkg_Error.SetErrorMessage(PKG_ERROR.CNUGENERIC_MESSAGE, 'Otros: No se encontro informacion de la orden');
        RAISE pkg_Error.Controlled_Error;
    END;

    --or_boorderactivities.createactivity
	api_createorder(nuactivity,
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    nuaddress,
                    NULL,
                    inuContactId,
                    nuContrato,
                    nuproduct_id,
                    NULL,
                    NULL,
                    NULL,
                    'Orden Generada desde pGenSusp_UsuNoAutoriza',
                    NULL,
                    NULL,
					NULL,
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    0, 
                    NULL,
                    NULL,
                    NULL,
                    NULL,
                    nuOrderval,
                    nuNewOrderActivityId,
                    onuErrorCode,
                    osbErrorMessage				
					);

      IF nuOrderval IS NULL THEN
        pkg_Error.GetError(onuErrorCode, sbmensa);
        RAISE pkg_Error.Controlled_Error;
      ELSE
              NULL;
      END IF;

	pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
	 pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
      RAISE;
    WHEN OTHERS THEN
      sbmensa := 'Proceso termino con Errores. ' || SQLERRM;
      Pkg_Error.SetError;
	  pkg_traza.trace(csbMT_NAME||' '||sbmensa, cnuNVLTRC);
	  pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      RAISE pkg_Error.Controlled_Error;
  END pGenSusp_UsuNoAutoriza;

  FUNCTION pValidaActividadVSI(nuactivity IN NUMBER, nusubscription_id IN NUMBER , sbMensaje OUT varchar2)
    RETURN NUMBER iS
    /**************************************************************************
     Autor       : Daniel Valiente / Horbath
     Fecha       : 2020-12-23
     Ticket      : 263
     Proceso     : pValidaActividadVSI 
     Descripcion : Valida si la actividad seleccionada corresponde a la actividad de suspensión indicada

     HISTORIA DE MODIFICACIONES
     FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    onuErrorCode NUMBER;
    sbmensa      VARCHAR2(10000);
    nucontador NUMBER;
    sbActividades ld_parameter.value_chain%TYPE :=dald_parameter.fsbGetValue_Chain('ACTIVIDADES_CALIDAD_MEDICION',NULL);
    nuActividad   ge_items.items_id%TYPE;
    sbOutAtri  varchar2(4000):='1';
    sbPackageId  varchar2(4000);
    nuPackageId  mo_packages.package_id%TYPE;
    nuMotiveId   mo_motive.motive_id%TYPE;
    nuUnidad     or_operating_unit.operating_unit_id%TYPE;
    sbInstance                 varchar2(32767);
    sbFather                   varchar2(32767);
    nuProduct                  pr_product.product_id%TYPE;
	
	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.pValidaActividadVSI';

	CURSOR cuProducto(inusubscription_id suscripc.susccodi%TYPE)IS
	   SELECT product_id
	   FROM pr_product p
	   WHERE p.subscription_id=inusubscription_id
		 AND p.product_type_id=pkg_parametros.fnuGetValorNumerico('SERVICIO_GAS_CLM');

	CURSOR cuValTipoSusp(inuProducto pr_product.product_id%TYPE,
						 isbActividades VARCHAR2
	                     ) IS
	   SELECT activity_id, operating_unit_id
	   FROM (
	   SELECT oo1.order_id, oa1.activity_id, oo1.legalization_Date, oo1.operating_unit_id
			  FROM or_order oo1, ge_causal gc1, or_order_activity oa1
			 WHERE oa1.product_id = inuProducto
			   AND oa1.activity_id IN
									 (
										 SELECT to_number(regexp_substr(isbActividades,
																		'[^,]+',
																		1,
																		LEVEL)) AS tipo_trab
										 FROM dual
										 CONNECT BY regexp_substr(isbActividades, '[^,]+', 1, LEVEL) IS NOT NULL
									  )
			   AND oo1.order_status_id IN (8)
			   AND gc1.causal_id = oo1.causal_id
			   AND oa1.order_id = oo1.order_id
		  ORDER BY legalization_Date desc)
		WHERE rownum=1;

	
  BEGIN

	pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
    /*LOGICA: permitirá validar si la actividad seleccionada corresponde a la actividad de suspensión indicada. 
	  Por ejemplo, si el producto se encuentra suspendido por SUSPENSIÓN POR CDM ¿ CALIDAD DE LA MEDICIÓN, 
	  entonces la actividad a seleccionar deberá ser RECONEXIÓN POR CDM ¿ CALIDAD DE LA MEDICIÓN, 
	  para ello se buscará la última orden legalizada con causal de éxito, que no sea novedad y que el tipo de trabajo 
	  se encuentre configurado en el parámetro LDC_TT_GEN_NOTIFICACION*/

    IF 
	   INSTR(DALD_PARAMETER.fsbGetValue_Chain('EXEC_VALIDAR_ACTIVI_CALIMED',NULL),ut_session.getmodule)!=0 THEN 
      --Se valida si el producto esta suspendido por centro de medicion o si no esta suspendido.
      --Y la orden que se va a genererar es de calidad de la medición
      --Se debe generar la etapa por donde va.
      --Si esta suspendido por acometida debe generar reinstalación
      pkg_traza.trace('nuactivity'||nuactivity,cnuNVLTRC);
      IF INSTR(sbActividades,nuactivity||',')>0 THEN 
         nucontador := 0;
         BEGIN

			IF cuProducto%ISOPEN THEN
				CLOSE cuProducto;
			END IF;
			
			OPEN cuProducto(nusubscription_id);
			FETCH cuProducto INTO nuProduct;
			IF cuProducto%NOTFOUND THEN
				CLOSE cuProducto;
				RAISE no_data_found;
			END IF;
			CLOSE cuProducto;
			
         EXCEPTION
           WHEN NO_DATA_FOUND THEN
             nuProduct := NULL;
           WHEN others THEN
             nuProduct := NULL;
         END;
         IF nuProduct IS NULL THEN
            sbMensaje :='No se encontro el numero de producto.';
            RETURN 0;
         END IF;

         IF pValidaTipoSuspension(nuproduct) IN ('CM') THEN
           BEGIN
		   
			IF cuValTipoSusp%ISOPEN THEN
				CLOSE cuValTipoSusp;
			END IF;
			
			OPEN cuValTipoSusp(nuproduct, sbActividades);
			FETCH cuValTipoSusp INTO nuActividad,nuUnidad;
			IF cuValTipoSusp%NOTFOUND THEN
				CLOSE cuValTipoSusp;
				RAISE NO_DATA_FOUND;
			END IF;
			CLOSE cuValTipoSusp;
				
            EXCEPTION
              WHEN NO_DATA_FOUND THEN
                nuActividad := NULL;
              WHEN others THEN
                nuActividad := NULL;
            END;
			
            IF nvl(nuActividad, 0) = nuactivity THEN
                nucontador := 1;
                sbMensaje := NULL;
            ELSE
                nucontador := 0;
                sbMensaje := 'La actividad correcta a generar es '||nvl(nuActividad, 0)||' '||dage_items.fsbgetdescription(nuActividad, NULL);
            END IF;
         ELSE 
           IF pValidaTipoSuspension(nuproduct) = 'AC' THEN
             nucontador := 0;
             sbMensaje := 'Se debe generar el tramite de reconexion por calidad de la medicion. ';
           ELSE
             sbMensaje:= NULL;
             RETURN 1;
           END IF;
         END IF;

      --finalizamos el proceso
      IF nucontador > 0 THEN
         GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);
         GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(sbInstance, NULL, 'MO_MOTIVE', 'PACKAGE_ID', nuPackageId);

         IF nuPackageId IS NULL THEN 
           sbMensaje :='No se encontro el numero de solicitud.';
           RETURN 0;
         END IF;
         pkg_traza.trace('nuPackageId'||nuPackageId,cnuNVLTRC);
             INSERT INTO LDC_ORDEASIGPROC
            (ORAPORPA,
             ORAPSOGE,
             ORAOPELE,
             ORAOUNID,
             ORAOCALE,
             ORAOITEM,
             ORAOPROC)
          VALUES
            (NULL,
             nuPackageId,
             NULL,
             nuUnidad,
             NULL,
             NULL,
             'SEVAASAU');

        RETURN 1;

      ELSE
        RETURN 0;
      END IF;
      ELSE 
        RETURN 1;
      END IF;
    ELSE
      sbMensaje:=NULL;
      RETURN 1;
    END IF;
	
	pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
	
  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.GetError(onuErrorCode, sbmensa);
	  pkg_traza.trace(csbMT_NAME||' '||sbmensa, cnuNVLTRC);
	  pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
      RAISE;
    WHEN OTHERS THEN
      sbmensa := 'Proceso termino con Errores. ' || SQLERRM;
      Pkg_Error.SetError;
	  pkg_traza.trace(csbMT_NAME||' '||sbmensa, cnuNVLTRC);
	  pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      RAISE pkg_Error.Controlled_Error;
  END pValidaActividadVSI;

  PROCEDURE pPluginGeneraReconexion IS
    /******************************************************************************
     Autor       : Daniel Valiente / Horbath
     Fecha       : 2020-12-23
     Ticket      : 263
     Proceso     : pPluginGeneraReconexion 
     Descripcion : procedimiento para validar si creará el trámite de reconexión

     HISTORIA DE MODIFICACIONES
     FECHA        AUTOR           DESCRIPCION
     12-05-2023   Yazmin.esquivel OSF-1090: Se retira validación de tipo de causal
    *******************************************************************************/
    onuErrorCode NUMBER;
    sbmensa      VARCHAR2(10000);
    nucausal         NUMBER;
    nuorden          NUMBER;
    nuproducto       NUMBER;
    sbRequestXML     constants_per.tipo_xml_sol%type;
    nuMedioRecepcion NUMBER := dald_parameter.fnugetnumeric_value('PAR_RECEPTYPEID_CDM_RECONEXION',
                                                                  NULL);
    nuTipoSuspension NUMBER := dald_parameter.fnugetnumeric_value('PAR_TIPOSUSP_CDM_RECONEXION',
                                                                  NULL);
    inuIdAddress     NUMBER;
    inuContactId     NUMBER;
    nuPackageId      mo_packages.package_id%TYPE;
    nuMotiveId       mo_motive.motive_id%TYPE;
    nuUnidad         or_operating_unit.operating_unit_id%TYPE;
	sbComentario     mo_packages.comment_%TYPE;
	
	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.pPluginGeneraReconexion';

	CURSOR cuDatosSoli(inuOrden or_order.order_id%TYPE) IS
	  SELECT PR.ADDRESS_ID, s.SUSCCLIE, oa.product_id
        FROM PR_PRODUCT PR, SUSCRIPC s, or_order_activity oa, pr_prod_suspension s
       WHERE PR.SUBSCRIPTION_ID = S.SUSCCODI
         AND PR.PRODUCT_ID = oa.product_id
         AND oa.order_id= inuorden
         AND s.product_id=pr.product_id
         AND s.active='Y'
         AND s.suspension_type_id = dald_parameter.fnuGetNumeric_Value('PAR_TIPOSUSP_CDM', NULL)
         AND ROWNUM = 1;


  BEGIN


	pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	
    /*LOGICA: validará si la causal de legalización es de éxito, que el producto se encuentre suspendido por CDM (por calidad de medición) y creará el trámite de reconexión (explicado más adelante), el cual a su vez generará la orden dependiendo de la regla que aplique. Este servicio será un plugin que podrá ser configurado por Datos Maestros*/
    nuorden := pkg_bcordenes.fnuObtenerOTInstanciaLegal;
    nucausal := pkg_bcordenes.fnuObtieneCausal(nuorden);
    nuUnidad := pkg_bcordenes.fnuObtieneUnidadOperativa(nuorden);

        BEGIN

           IF (cuDatosSoli%ISOPEN) THEN
	      	    CLOSE cuDatosSoli;
		   END IF;

			OPEN cuDatosSoli(nuorden);
			FETCH cuDatosSoli INTO inuIdAddress, inuContactId, nuproducto;
				IF cuDatosSoli%NOTFOUND THEN
					CLOSE cuDatosSoli;
					RAISE NO_DATA_FOUND;
				END IF;
            CLOSE cuDatosSoli;

        EXCEPTION
		    WHEN NO_DATA_FOUND THEN
			pkg_traza.trace('Plugin pPluginGeneraReconexion: No se encontro información de producto suspendido por vpm');
			RETURN;
           WHEN others THEN
            pkg_traza.trace('Plugin pPluginGeneraReconexion: Otros: No se encontro información de producto suspendido por vpm');
            RETURN;
        END;

		sbComentario := 'Reconexion del Producto '||nuproducto;

		sbRequestXML := pkg_xml_soli_calid_medic.getSolicitudReconexionCLM(nuMedioRecepcion,
		                                                                   sbComentario,
																		   nuproducto,
																		   inuContactId,
																		   nuTipoSuspension
																		   );

          Api_RegisterRequestByXML (sbRequestXML,
                                    nuPackageId,
                                    nuMotiveId,
                                    onuErrorCode,
                                    sbmensa);

          IF nupackageid IS NULL THEN
            RAISE pkg_Error.Controlled_Error;
          ELSE
              INSERT INTO LDC_ORDEASIGPROC
            (ORAPORPA,
             ORAPSOGE,
             ORAOPELE,
             ORAOUNID,
             ORAOCALE,
             ORAOITEM,
             ORAOPROC)
          VALUES
            (nuorden,
             nuPackageId,
             pkg_bcordenes.fnuObtenerPersona(nuorden),
             nuUnidad,
             nuCausal,
             NULL,
             'RECONEX_CALMED');
          END IF;

    --finalizamos el proceso
	pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
	  pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
      RAISE;
    WHEN OTHERS THEN
      sbmensa := 'Proceso termino con Errores. ' || SQLERRM;
      Pkg_Error.SetError;
	  pkg_traza.trace(csbMT_NAME||' '||sbmensa, cnuNVLTRC);
	  pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      RAISE pkg_Error.Controlled_Error;
  END pPluginGeneraReconexion;

  FUNCTION pGestionaOrdenVMP_RECO(inuPackage_id     IN NUMBER,
                                  isbtypesuspension IN VARCHAR2)
    RETURN NUMBER IS
    /**************************************************************************
     Autor       : Daniel Valiente / Horbath
     Fecha       : 2020-12-23
     Ticket      : 263
     Proceso     : pGestionaOrdenVMP_RECO
     Descripcion : funcion para gestionar ordenes de Reconexion VPM

     HISTORIA DE MODIFICACIONES
     FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    onuErrorCode NUMBER;
    nuparano     NUMBER(4);
    nuparmes     NUMBER(2);
    nutsess      NUMBER;
    sbparuser    VARCHAR2(30);
    sbmensa      VARCHAR2(10000);
    nupackagetype NUMBER;
    nuactprev     NUMBER;
    nucontador    NUMBER;
    nuproducto    NUMBER;
    sbTipoSusup   varchar2(10);
    v_out NUMBER := 1;
    sbIntancia VARCHAR2(200);
    sbProductId  varchar2(4000);

    csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.pGestionaOrdenVMP_RECO';

    CURSOR cuProducto(inuSolicitud mo_packages.package_id%TYPE) IS
	  SELECT product_id
      FROM mo_motive
      WHERE package_id = inuSolicitud;


  BEGIN

	pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	
    /*LOGICA: validará la categoría del producto y la última actividad de suspensión y dependiendo de esos datos generará la orden de trabajo*/
    --categoria del producto
    --pendiente de validar si se requiere
    --ultima actividad de suspension de solicitud
    nuactprev := 0;

    BEGIN

	  IF (cuProducto%ISOPEN) THEN
          CLOSE cuProducto;	  
	  END IF;

      OPEN cuProducto(inuPackage_id);
      FETCH cuProducto INTO nuproducto;
		IF cuProducto%NOTFOUND THEN
			CLOSE cuProducto;
			RAISE NO_DATA_FOUND;
		END IF;
      CLOSE cuProducto;

    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        nuproducto := NULL;
      WHEN others THEN
        nuproducto := NULL;
    END;

    IF nuproducto IS NULL THEN
      Pkg_Error.SetErrorMessage(PKG_ERROR.CNUGENERIC_MESSAGE, 'No se encontro producto '||inuPackage_id);
      RAISE pkg_Error.Controlled_Error;
    END IF;

    sbTipoSusup := pValidaTipoSuspension(nuproducto);

    IF isbtypesuspension = sbTipoSusup THEN
      nucontador :=1;
    ELSE
      nucontador:=0;
    END IF;

      IF nucontador > 0 THEN
        RETURN 1;
      ELSE
        RETURN 0;
      END IF;
	  
	  pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
	  pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
      RAISE;
    WHEN OTHERS THEN
      sbmensa := 'Proceso termino con Errores. ' || SQLERRM;
      Pkg_Error.SetError;
	  pkg_traza.trace(csbMT_NAME||' '||sbmensa, cnuNVLTRC);
	  pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      RAISE pkg_Error.Controlled_Error;
  END pGestionaOrdenVMP_RECO;

  PROCEDURE pJobGeneraReconexion IS
    /**************************************************************************
     Autor       : Daniel Valiente / Horbath
     Fecha       : 2020-12-23
     Ticket      : 263
     Proceso     : pJobGeneraReconexion 
     Descripcion : procedimiento para legalizar reconexión

     HISTORIA DE MODIFICACIONES
     FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    onuErrorCode NUMBER;
    sbmensa      VARCHAR2(10000);    nuproduct NUMBER;
    CURSOR cuOrdenReconexion IS
      SELECT pr.oraporpa ot_padre, ORAOUNID unidad, oo.order_id, oa.order_activity_id, oa.product_id, oa.package_id,
             (SELECT p.person_id FROM or_order_person p WHERE p.order_id=pr.oraporpa) person_id
        FROM or_order oo, or_order_activity oa, mo_packages mp, LDC_ORDEASIGPROC pr
       WHERE oo.order_id = oa.order_id
         AND oa.package_id = mp.package_id
         AND oo.order_status_id = 0
         AND mp.package_type_id = 100331
         AND mp.package_id=pr.orapsoge
         AND pr.oraoproc='RECONEX_CALMED';
    CURSOR cuDatosOrdenPadre(nucuorden NUMBER) IS
      SELECT ot.operating_unit_id,
             ot.EXECUTION_FINAL_DATE,
             oa.product_id,
             ot.EXEC_INITIAL_DATE 
        FROM or_order_activity oa, or_order ot, mo_packages m
       WHERE oa.order_id = nucuorden
         AND oa.package_id IS NOT NULL
         AND oa.order_id = ot.order_id
         AND ot.order_status_id = 8
         AND oa.package_id = m.package_id
         AND rownum = 1;
		 
    continuar         NUMBER;
    nuunidadoperativa NUMBER;
    nuCausalLegaReco  ge_causal.causal_id%TYPE := Dald_parameter.fnuGetNumeric_Value('LDC_CAUSLEGRECCDM',
                                                                                     NULL);
																					 

    nuParaLectReco NUMBER := Dald_parameter.fnuGetNumeric_Value('COD_ATRIBUTO_LECTURACM',
                                                                NULL);
																
    CURSOR cuLecturaOrdePadre(nuParametro NUMBER, nuOrden NUMBER) IS
			select 
				  case when nvl(r.name_1,'-1')= nvl(atr.name_attribute,'-2') then r.value_1
					   when nvl(r.name_2,'-1')= nvl(atr.name_attribute,'-2') then r.value_2
					   when nvl(r.name_3,'-1')= nvl(atr.name_attribute,'-2') then r.value_3
					   when nvl(r.name_4,'-1')= nvl(atr.name_attribute,'-2') then r.value_4
					   when nvl(r.name_5,'-1')= nvl(atr.name_attribute,'-2') then r.value_5                                    
					   when nvl(r.name_6,'-1')= nvl(atr.name_attribute,'-2') then r.value_6                 
					   when nvl(r.name_7,'-1')= nvl(atr.name_attribute,'-2') then r.value_7            
					   when nvl(r.name_8,'-1')= nvl(atr.name_attribute,'-2') then r.value_8
					   when nvl(r.name_9,'-1')= nvl(atr.name_attribute,'-2') then r.value_9
					   when nvl(r.name_10,'-1')= nvl(atr.name_attribute,'-2') then r.value_10
					   when nvl(r.name_11,'-1')= nvl(atr.name_attribute,'-2') then r.value_11
					   when nvl(r.name_12,'-1')= nvl(atr.name_attribute,'-2') then r.value_12
					   when nvl(r.name_13,'-1')= nvl(atr.name_attribute,'-2') then r.value_13
					   when nvl(r.name_14,'-1')= nvl(atr.name_attribute,'-2') then r.value_14
					   when nvl(r.name_15,'-1')= nvl(atr.name_attribute,'-2') then r.value_15
					   when nvl(r.name_16,'-1')= nvl(atr.name_attribute,'-2') then r.value_16
					   when nvl(r.name_17,'-1')= nvl(atr.name_attribute,'-2') then r.value_17
					   when nvl(r.name_18,'-1')= nvl(atr.name_attribute,'-2') then r.value_18
					   when nvl(r.name_19,'-1')= nvl(atr.name_attribute,'-2') then r.value_19                                                                                                                                                                                                           
					   when nvl(r.name_20,'-1')= nvl(atr.name_attribute,'-2') then r.value_20                                                                                                                                                                                                           
				 end valor
		   from open.or_requ_data_value r
		   inner join ge_attrib_set_attrib atrxgr on atrxgr.attribute_set_id = r.attribute_set_id  
		   inner join ge_attributes_set gr on gr.attribute_set_id = r.attribute_set_id 
		   inner join ge_attributes atr on atr.attribute_id=atrxgr.attribute_id and 
				(
					   nvl(r.name_1,'-1')= nvl(atr.name_attribute,'-2') 
					or nvl(r.name_2,'-1')= nvl(atr.name_attribute,'-2') 
					or nvl(r.name_3,'-1')= nvl(atr.name_attribute,'-2') 
					or nvl(r.name_4,'-1')= nvl(atr.name_attribute,'-2') 
					or nvl(r.name_5,'-1')= nvl(atr.name_attribute,'-2') 
					or nvl(r.name_6,'-1')= nvl(atr.name_attribute,'-2') 
					or nvl(r.name_7,'-1')= nvl(atr.name_attribute,'-2') 
					or nvl(r.name_8,'-1')= nvl(atr.name_attribute,'-2') 
					or nvl(r.name_9,'-1')= nvl(atr.name_attribute,'-2') 
					or nvl(r.name_10,'-1')= nvl(atr.name_attribute,'-2')
					or nvl(r.name_11,'-1')= nvl(atr.name_attribute,'-2') 
					or nvl(r.name_12,'-1')= nvl(atr.name_attribute,'-2') 
					or nvl(r.name_13,'-1')= nvl(atr.name_attribute,'-2') 
					or nvl(r.name_14,'-1')= nvl(atr.name_attribute,'-2')
					or nvl(r.name_15,'-1')= nvl(atr.name_attribute,'-2')
					or nvl(r.name_16,'-1')= nvl(atr.name_attribute,'-2')
					or nvl(r.name_17,'-1')= nvl(atr.name_attribute,'-2')
					or nvl(r.name_18,'-1')= nvl(atr.name_attribute,'-2')
					or nvl(r.name_19,'-1')= nvl(atr.name_attribute,'-2') 
					or nvl(r.name_20,'-1')= nvl(atr.name_attribute,'-2') 
				 )
	   where r.order_id = nuOrden
	   and atr.attribute_id = nuParametro;


    sbItemLegaReco VARCHAR2(1000) := NULL;
    nuClaseCausal  NUMBER;

    CURSOR cuTipoCausal(nuCausal ge_causal.CAUSAL_ID%TYPE) IS
      SELECT DECODE(CLASS_CAUSAL_ID, 1, 1, 2, 0) tipo
        FROM ge_causal
       WHERE CAUSAL_ID = nuCausal;

	dtFechaEjecFin or_order.EXECUTION_FINAL_DATE%TYPE;

	CURSOR cuMedidor(dtFechaEjec DATE, nuproductid NUMBER) IS
      SELECT emsscoem
        FROM elmesesu
       WHERE emsssesu = nuproductid
         AND dtFechaEjec between EMSSFEIN AND EMSSFERE;

    CURSOR cuMedidorAct(nuproductid NUMBER) IS
      SELECT emsscoem
        FROM elmesesu
       WHERE emsssesu = nuproductid
         AND SYSDATE between EMSSFEIN AND EMSSFERE;

    CURSOR cuTipoSuspencion(nuProducto pr_product.product_id%TYPE) IS
      SELECT Ge_Suspension_Type.Suspension_Type_Id Id
        FROM Ge_Suspension_Type, Ps_Sustyp_By_Protyp, Pr_Product
       WHERE Pr_Product.Product_Id = nuProducto
         AND Ps_Sustyp_By_Protyp.Product_Type_Id =
             Pr_Product.Product_Type_Id
         AND Ge_Suspension_Type.Class_Suspension = 'A'
         AND Ge_Suspension_Type.Suspension_Type_Id =
             Ps_Sustyp_By_Protyp.Suspension_Type_Id
         AND Exists (SELECT 'X'
                FROM Pr_Prod_Suspension PS
               WHERE PS.Product_Id = Pr_Product.Product_Id
                 AND PS.Suspension_Type_Id =
                     Ge_Suspension_Type.Suspension_Type_Id
                 AND Active = 'Y');

    CURSOR cuUltimaLectura(nuProducto NUMBER) IS
      SELECT leemleto
        FROM (SELECT leemfele, leemleto
                FROM lectelme
               WHERE leemsesu = nuProducto
                 AND leemleto IS NOT NULL
               ORDER BY leemfele desc)
       WHERE rownum = 1;

    nuLectura          NUMBER;
    nuPersonaLega      ge_person.person_id%TYPE;
    nuTipoSuspLega     NUMBER;
    MedidorLega        varchar2(100);
    Medidor            varchar2(100);
    MedidorAct         varchar2(100);
    dtFechaEjecFinLega or_order.EXECUTION_FINAL_DATE%TYPE;
    sbCadenalega       VARCHAR2(4000);
    dtFechaEjecIni     or_order.EXEC_INITIAL_DATE%TYPE;
	
	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.pJobGeneraReconexion';
	sbProceso	VARCHAR2(70) := 'pJobGeneraReconexion'||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');

  BEGIN
  
	pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
    -- Inicializamos el proceso
	pkg_estaproc.prInsertaEstaproc(sbProceso,NULL);

    /*LOGICA: buscará las órdenes de trabajo, asociadas al trámite de Reconexión por calidad de medición, que se encuentren en estado 0 ¿ Registrado y realizará lo siguiente:
    ¿ Este servicio estará basado en el servicio ¿ldc_pkgrepegelerecoysusp.job_legaordenrecoysuspadmi¿
    */
    FOR reg IN cuOrdenReconexion LOOP
      BEGIN

          /*¿ Asignará la orden a la unidad de trabajo que legalizó la orden que generó este trámite de reconexión.*/
          OPEN cuLecturaOrdePadre(nuParaLectReco,reg.ot_padre);
          FETCH cuLecturaOrdePadre
            INTO nuLectura;
          CLOSE cuLecturaOrdePadre;

          IF cuDatosOrdenPadre%isopen THEN
             	CLOSE cuDatosOrdenPadre;
          END IF;
          OPEN cuDatosOrdenPadre(reg.ot_padre);
          FETCH cuDatosOrdenPadre
            INTO nuunidadoperativa, dtFechaEjecfIN, nuproduct, dtFechaEjecIni;
          IF cuDatosOrdenPadre%NOTFOUND THEN
            continuar := 0;
          ELSE
            dtFechaEjecfIN := dtFechaEjecfIN + 1 / 24;
            OPEN cuTipoCausal(nuCausalLegaReco);
            FETCH cuTipoCausal
              INTO nuClaseCausal;
            CLOSE cuTipoCausal;
            OPEN cuTipoSuspencion(nuproduct);
            FETCH cuTipoSuspencion
              INTO nuTipoSuspLega;
            CLOSE cuTipoSuspencion;
            OPEN cuMedidor(dtFechaEjecfIN, nuproduct);
            FETCH cuMedidor
              INTO MedidorLega;
            CLOSE cuMedidor;
            OPEN cuMedidorAct(nuproduct);
            FETCH cuMedidorAct
              INTO MedidorAct;
            CLOSE cuMedidorAct;

            Medidor := MedidorAct;

            IF MedidorLega != MedidorAct THEN
              dtFechaEjecFinLega := SYSDATE;
              OPEN cuUltimaLectura(nuproduct);
              FETCH cuUltimaLectura
                INTO nuLectura;
              CLOSE cuUltimaLectura;
            ELSE
              dtFechaEjecFinLega := dtFechaEjecfIN;
            END IF;
            Api_Assign_Order(reg.order_id,
                            nuunidadoperativa,
                            onuErrorCode,
                            sbmensa);
            IF onuErrorCode = 0 THEN

              /*¿ Una vez asignada la orden, la legalizará con causal de éxito */
              sbCadenalega := reg.order_id || '|' || nuCausalLegaReco || '|' ||
                              reg.person_id || '||' || reg.order_activity_id || '>' ||
                              nuClaseCausal || ';READING>' || NVL(nuLectura, '') ||
                              '>9>;SUSPENSION_TYPE>' || NVL(nuTipoSuspLega, '') ||
                              '>>;;|' || NVL(sbItemLegaReco, '') || '|' ||
                              Medidor || ';1=' || NVL(nuLectura, '') || '=T===|' ||
                              '1277;Orden Legalizada por proceso pJobGeneraReconexion';
              onuErrorCode :=NULL;
              sbmensa      :=NULL;
              Api_legalizeorders(sbCadenalega,
                                dtFechaEjecIni,
                                dtFechaEjecFinLega,
                                NULL,
                                onuErrorCode,
                                sbmensa);
             IF onuErrorCode = 0 THEN
               COMMIT;
             ELSE 
               ROLLBACK;
               sbmensa := 'Error al legalizar la orden: '||sbmensa;
               Pkg_Error.SetErrorMessage(PKG_ERROR.CNUGENERIC_MESSAGE, sbmensa);
               RAISE pkg_Error.Controlled_Error;
               --No se pudo Legalizar
             END IF;
            ELSE
               ROLLBACK;
               sbmensa := 'Error al asignar la orden: '||sbmensa;
               Pkg_Error.SetErrorMessage(PKG_ERROR.CNUGENERIC_MESSAGE, sbmensa);
               RAISE pkg_Error.Controlled_Error;
              --No se pudo asignar
            END IF;
          END IF;
          CLOSE cuDatosOrdenPadre;
       EXCEPTION 
           WHEN pkg_Error.Controlled_Error THEN
                 ROLLBACK;
                 pkg_Error.GetError(onuErrorCode, sbmensa);             
                 INSERT INTO LDC_LOG_PROCESO_VMP(LOG_PROCESO_VMP_ID,PRODUCTO,FECHA_REGISTRO,MENSAJE_ERROR, proceso, PROCESADO, SOLICITUD) values(SEQ_LDC_LOG_PROCESO_VMP.NEXTVAL,reg.product_id, SYSDATE,'Error al Generar tramite: '||sbmensa,'pJobGeneraReconexion','S', reg.package_id);
                 COMMIT;
            WHEN others THEN
               ROLLBACK;
               Pkg_Error.SetError;
               pkg_Error.GetError(onuErrorCode, sbmensa);
              INSERT INTO LDC_LOG_PROCESO_VMP(LOG_PROCESO_VMP_ID,PRODUCTO,FECHA_REGISTRO,MENSAJE_ERROR, proceso,PROCESADO, SOLICITUD) values(SEQ_LDC_LOG_PROCESO_VMP.NEXTVAL,reg.product_id, SYSDATE,'Error al Generar tramite: '||sbmensa,'pJobGeneraReconexion','S', reg.package_id);
              COMMIT;
     END;
    END LOOP;
    --finalizamos el proceso

	pkg_estaproc.prActualizaEstaproc(sbProceso,'Finalizado','Ok');
	
	pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.GetError(onuErrorCode, sbmensa);
	  pkg_estaproc.prActualizaEstaproc(sbProceso,'Error',sbmensa);
	  pkg_traza.trace(csbMT_NAME||' '||sbmensa, cnuNVLTRC);
	  pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
      RAISE;
    WHEN OTHERS THEN
      Pkg_Error.SetError;
      pkg_Error.GetError(onuErrorCode, sbmensa);
      sbmensa := sbmensa||' Proceso termino con Errores. ' || SQLERRM;
	  pkg_estaproc.prActualizaEstaproc(sbProceso,'Error',sbmensa);
	  pkg_traza.trace(csbMT_NAME||' '||sbmensa, cnuNVLTRC);
	  pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
  END pJobGeneraReconexion;

  PROCEDURE pProcesaOrdParaAnuServ IS
    /**************************************************************************
     Autor       : Daniel Valiente / Horbath
     Fecha       : 2020-12-23
     Ticket      : 263
     Proceso     : pProcesaOrdParaAnuServ
     Descripcion : procedimiento para validar la creacion masiva de VSI

     HISTORIA DE MODIFICACIONES
     FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    onuErrorCode NUMBER;
    sbmensa      VARCHAR2(10000);
    swvalida NUMBER;

    CURSOR cuOrdenes IS
      SELECT oo.order_id
        FROM or_order oo
       WHERE oo.task_type_id IN
	                            (
                                     SELECT to_number(regexp_substr(dald_parameter.fsbgetvalue_chain('LDC_TT_USU_SUSPEND',NULL),
                                                                   '[^,]+',
                                                                    1,
                                                                    LEVEL)) AS tipo_trab_
                                     FROM dual
                                     CONNECT BY regexp_substr(dald_parameter.fsbgetvalue_chain('LDC_TT_USU_SUSPEND',NULL), '[^,]+', 1, LEVEL) IS NOT NULL
								)
         AND oo.causal_id IN
								(
                                     SELECT to_number(regexp_substr(dald_parameter.fsbgetvalue_chain('LDC_CAUSA_USU_SUSPEND',NULL),
                                                                   '[^,]+',
                                                                    1,
                                                                    LEVEL)) AS causal_
                                     FROM dual
                                     CONNECT BY regexp_substr(dald_parameter.fsbgetvalue_chain('LDC_CAUSA_USU_SUSPEND',NULL), '[^,]+', 1, LEVEL) IS NOT NULL
								)
         AND oo.order_status_id IN (8)
         AND TO_DATE(TO_CHAR(SYSDATE, 'DD-MM-YYYY'), 'DD-MM-YYYY') -
             TO_DATE(TO_CHAR(oo.legalization_date, 'DD-MM-YYYY'),
                     'DD-MM-YYYY') >=
             dald_parameter.fnuGetNumeric_Value('LDC_CANT_DIAS_NOREPARA');


	CURSOR cuProdSolicitud(inuOrden or_order.order_id%TYPE) IS
	  SELECT oa.product_id, oa.operating_unit_id
      FROM or_order_activity oa
      WHERE oa.order_id = inuOrden;

    CURSOR cuContadorOrdCerr(inuProducto pr_product.product_id%TYPE) IS	  
	  SELECT COUNT(*)
        FROM or_order oo, ge_causal gc, or_order_activity oa
       WHERE oa.product_id = inuProducto
         AND oo.order_status_id IN (8)
         AND gc.causal_id = oo.causal_id
         AND gc.class_causal_id = 1
         AND oa.order_id = oo.order_id
         AND oa.activity_id IN (100009044, 100009045, 100009048)
         AND oo.legalization_date IN
             (SELECT max(oo1.legalization_date)
                FROM or_order oo1, ge_causal gc1, or_order_activity oa1
               WHERE oa1.product_id = inuProducto
                 AND oo1.order_status_id IN (8)
                 AND gc1.causal_id = oo1.causal_id
                 AND gc1.class_causal_id = 1
                 AND oa1.order_id = oo1.order_id);

    CURSOR cuContadorOrdAb(inuProducto pr_product.product_id%TYPE,
	                       inuOrden or_order.order_id%TYPE
						  ) IS
      SELECT COUNT(*)
          FROM mo_packages mp, or_order_activity oa, or_order oo
         WHERE mp.package_type_id IN (100101)
           AND oa.package_id = mp.package_id
           AND oo.order_id = oa.order_id
           AND oo.order_status_id NOT IN (8)
           AND oa.product_id = inuProducto
           AND oa.activity_id IN
               (SELECT oa1.activity_id
                  FROM or_order_activity oa1
                 WHERE oa1.product_id = inuProducto
                   AND oa1.order_id = inuOrden)
           AND oa.order_id NOT IN (inuOrden);

    CURSOR cuContadorFechaVMP(inuProducto pr_product.product_id%TYPE) IS
	   SELECT COUNT(*)
         FROM ldc_plazos_cert pc
        WHERE pc.plazo_maximo < SYSDATE
          AND pc.id_producto = inuProducto;


	CURSOR cuContadorOrdAbPar(inuProducto pr_product.product_id%TYPE,
                              isbTTreconex ld_parameter.value_chain%TYPE,
                              IsbTtProceso ld_parameter.value_chain%TYPE) IS
	   SELECT COUNT(*)
         FROM or_order_activity ooa, or_order oo
        WHERE ooa.product_id = inuProducto
          AND oo.order_id = ooa.order_id
          AND oo.task_type_id IN
									(
                                     SELECT to_number(regexp_substr(isbTTreconex,
                                                                    '[^,]+',
                                                                    1,
                                                                    LEVEL)) AS tipo_trab_rec
                                     FROM dual
                                     CONNECT BY regexp_substr(isbTTreconex, '[^,]+', 1, LEVEL) IS NOT NULL

							        UNION ALL

                                     SELECT to_number(regexp_substr(isbTtProceso,
                                                                    '[^,]+',
                                                                    1,
                                                                    LEVEL)) AS tipo_trab_proc
                                     FROM dual
                                     CONNECT BY regexp_substr(isbTtProceso, '[^,]+', 1, LEVEL) IS NOT NULL
									)
         AND oo.order_status_id IN (0, 1, 5, 6, 7);

	CURSOR cuActAnulacion(inuProducto pr_product.product_id%TYPE) IS
	  SELECT COUNT(*)
          FROM or_order oo, ge_causal gc, or_order_activity ooa
         WHERE oo.causal_id = gc.causal_id
           AND ooa.order_id = oo.order_id
           AND oo.order_status_id IN (8)
           AND gc.class_causal_id = 1
           AND ooa.order_activity_id IN
										(
		                                SELECT to_number(regexp_substr(dald_parameter.fsbgetvalue_chain('PAR_ACTANUL',NULL),
                                                                       '[^,]+',
                                                                       1,
                                                                       LEVEL)) AS tipo_trab
                                        FROM dual
                                        CONNECT BY regexp_substr(dald_parameter.fsbgetvalue_chain('PAR_ACTANUL',NULL), '[^,]+', 1, LEVEL) IS NOT NULL

										)
           AND ooa.product_id IN (inuProducto);

	CURSOR cuDatosSoli(inuProducto pr_product.product_id%TYPE) IS
      SELECT PR.ADDRESS_ID, PR.SUBSCRIPTION_ID, s.SUSCCLIE
        FROM PR_PRODUCT PR, SUSCRIPC s
       WHERE PR.SUBSCRIPTION_ID = S.SUSCCODI
         AND PR.PRODUCT_ID = inuProducto
         AND ROWNUM = 1;



    nuorden          NUMBER;
    nucontador       NUMBER;
    nuproducto       NUMBER;
    sbRequestXML     constants_per.tipo_xml_sol%type;
    nuPersonIdsol    NUMBER := pkg_bopersonal.fnuGetPersonaId;
    nuPtoAtncndsol   NUMBER;
    nuMedioRecepcion NUMBER := dald_parameter.fnugetnumeric_value('LDC_MED_REC_VSI_USU_SUSP',
                                                                  NULL);
    actVSI           NUMBER := dald_parameter.fnugetnumeric_value('LDC_ACT_VSI_ANULA_SERV',
                                                                  NULL);
    sbcomment        varchar2(200) := dald_parameter.fsbGetValue_Chain('LDC_COMMENT_VSI_VMP',
                                                                       NULL);
    sbTTreconex      ld_parameter.value_chain%TYPE := dald_parameter.fsbgetvalue_chain('LDC_TT_RECON_ABIERTO',NULL);
    sbTtProceso      ld_parameter.value_chain%TYPE := dald_parameter.fsbgetvalue_chain('LDC_TT_PROCESO_ABIERTO',NULL);
    inuIdAddress     NUMBER;
    NuContrato       NUMBER;
    inuContactId     NUMBER;
    nuPackageId      mo_packages.package_id%TYPE;
    nuMotiveId       mo_motive.motive_id%TYPE;
    nuoperatingunit  NUMBER;
	
	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.pProcesaOrdParaAnuServ';
	sbProceso   VARCHAR2(70) := 'pProcesaOrdParaAnuServ'||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');
  BEGIN
  
	pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	
    -- Inicializamos el proceso
    pkg_estaproc.prInsertaEstaproc(sbProceso,NULL);

    /*LOGICA: se encargará de tomar todas las órdenes de los tipos de trabajo configurados en el parámetro LDC_TT_USU_SUSPEND, que hayan sido legalizadas con alguna de las causales configuradas en el parámetro LDC_CAUSA_USU_SUSPEND y que entre la fecha de legalización y la fecha de ejecución del servicio (SYSDATE) hayan pasado el número de días (mayor o igual) definido en el parámetro LDC_CANT_DIAS_NOREPARA y por cada orden realizará lo siguiente:*/
    nuPtoAtncndsol := pkg_bopersonal.fnuGetPuntoAtencionId(nuPersonIdsol);

    FOR tempcuOrdenes IN cuOrdenes LOOP
      swvalida := 1;
      nuorden  := tempcuOrdenes.Order_Id;
      /*¿ Validará que el producto se encuentre suspendido por ¿Calidad de la medición¿*/

	  IF (cuProdSolicitud%ISOPEN) THEN
	    CLOSE cuProdSolicitud;
	  END IF;

	  OPEN cuProdSolicitud(nuorden);
      FETCH cuProdSolicitud INTO nuproducto, nuoperatingunit;
      CLOSE cuProdSolicitud;

	  IF (cuContadorOrdCerr%ISOPEN) THEN
	     CLOSE cuContadorOrdCerr;
	  END IF;

  	  OPEN cuContadorOrdCerr(nuproducto);
      FETCH cuContadorOrdCerr INTO nucontador;
      CLOSE cuContadorOrdCerr;

      IF nucontador = 0 THEN
        swvalida := 0;
      END IF;

      /*¿ No debe existir otro trámite de VSI con la misma actividad en estado no terminal.*/
      IF swvalida = 1 THEN

	    IF(cuContadorOrdAb%ISOPEN) THEN
		  CLOSE cuContadorOrdAb; 
		END IF;

        OPEN cuContadorOrdAb(nuproducto,nuorden);
		FETCH cuContadorOrdAb INTO nuContador;
		CLOSE cuContadorOrdAb;

        IF nucontador > 0 THEN
          swvalida := 0;
        END IF;
      END IF;

      /*¿ Validará que la fecha de revisión VMP no esté vigente.*/
      IF swvalida = 1 THEN
        IF(cuContadorFechaVMP%ISOPEN) THEN
         CLOSE cuContadorFechaVMP;
		END IF;

        OPEN cuContadorFechaVMP(nuproducto);
		FETCH cuContadorFechaVMP INTO nucontador;
		CLOSE cuContadorFechaVMP;

        IF nucontador = 0 THEN
          swvalida := 0;
        END IF;
      END IF;

      /*¿ Validará que el producto no tenga una orden abierta del tipo de trabajo perteneciente al parámetro LDC_TT_RECON_ABIERTO*/
      IF swvalida = 1 THEN

         IF(cuContadorOrdAbPar%ISOPEN) THEN
		    CLOSE cuContadorOrdAbPar;
		 END IF;

         OPEN cuContadorOrdAbPar(nuproducto,sbTTreconex,sbTtProceso);
		 FETCH cuContadorOrdAbPar INTO nucontador;
		 CLOSE cuContadorOrdAbPar;

        IF nucontador > 0 THEN
          swvalida := 0;
        END IF;
      END IF;
      /*¿ Si el producto ya tiene una actividad de anulación legalizada con causal éxito (ge_causal.class_causal_id = 1) no debe generar el trámite VSI.
      */

      IF swvalida = 1 THEN

		 IF (cuActAnulacion%ISOPEN) THEN
		    CLOSE cuActAnulacion;
		 END IF;

	     OPEN cuActAnulacion(nuproducto);
		 FETCH cuActAnulacion INTO nucontador;
		 CLOSE cuActAnulacion;

        IF nucontador > 0 THEN
          swvalida := 0;
        END IF;
      END IF;

      /*¿ Si cumple las validaciones anteriores se creará un trámite de venta de servicios de ingeniería con la actividad almacenada en el parámetro LDC_ACT_VSI_ANULA_SERV
      ¿ Estegt6 trámite será creado con medio de recepción del parámetro LDC_MED_REC_VSI_USU_SUSP.
      ¿ El comentario de creación se obtendrá del parámetro LDC_COMMENT_VSI_VMP.*/
      IF swvalida = 1 THEN

        IF(cuDatosSoli%ISOPEN) THEN
		   CLOSE cuDatosSoli;
		END IF;

        OPEN cuDatosSoli(nuproducto);
		FETCH cuDatosSoli INTO inuIdAddress, NuContrato, inuContactId;
		CLOSE cuDatosSoli;

		sbRequestXML:= pkg_xml_soli_vsi.getSolicitudVSI(NuContrato,
														nuMedioRecepcion,
														sbcomment,
														nuproducto,
														inuContactId,
														nuPersonIdsol,
														nuPtoAtncndsol,
														SYSDATE,
														inuIdAddress,
														inuIdAddress,
														actVSI
														);

         Api_RegisterRequestByXML(sbRequestXML,
                                  nuPackageId,
                                  nuMotiveId,
                                  onuErrorCode,
                                  sbmensa);
        COMMIT;
        IF nupackageid IS NULL THEN
          RAISE pkg_Error.Controlled_Error;
        ELSE
          COMMIT;
        END IF;
      END IF;
    END LOOP;
    --finalizamos el proceso
    pkg_estaproc.prActualizaEstaproc(sbProceso,'Error','Ok');
	pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
	
  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.GetError(onuErrorCode, sbmensa);
	  pkg_estaproc.prActualizaEstaproc(sbProceso,'Error',sbmensa);
	  pkg_traza.trace(csbMT_NAME||' '||sbmensa, cnuNVLTRC);
	  pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
      RAISE;
    WHEN OTHERS THEN
      sbmensa := 'Proceso termino con Errores. ' || SQLERRM;
	  pkg_estaproc.prActualizaEstaproc(sbProceso,'Error',sbmensa);
      Pkg_Error.SetError;
	  pkg_traza.trace(csbMT_NAME||' '||sbmensa, cnuNVLTRC);
	  pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      RAISE pkg_Error.Controlled_Error;
  END pProcesaOrdParaAnuServ;

  FUNCTION pValidaTipoSuspension(inuProduct_id IN NUMBER) RETURN varchar2 IS
    /**************************************************************************
     Autor       : Daniel Valiente / Horbath
     Fecha       : 2020-12-23
     Ticket      : 263
     Proceso     : pValidaTipoSuspension
     Descripcion : Valida el tipo de Suspension Aplicado al Producto AC / CM

     HISTORIA DE MODIFICACIONES
     FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    sbresultado varchar2(5);
    actividad   NUMBER;
    CURSOR cuActividad IS
    SELECT a.activity_id
    FROM pr_product p, or_order_Activity a, pr_prod_suspension s
    WHERE p.product_id=inuProduct_id
      AND p.product_status_id=2
      AND p.suspen_ord_act_id=a.order_activity_id
      AND s.product_id = p.product_id
      AND s.active = 'Y'
      AND s.suspension_type_id= dald_parameter.fnuGetNumeric_Value('PAR_TIPOSUSP_CDM', NULL);

   CURSOR cuValidaActi(sbActiviPara ld_parameter.value_chain%TYPE,
                       nuActividad ge_items.items_id%TYPE) IS
   SELECT COUNT(1)
   FROM (
         SELECT to_number(regexp_substr(sbActiviPara,
                                        '[^,]+',
                                        1,
                                        LEVEL)) AS valor
                      FROM dual
                      CONNECT BY regexp_substr(sbActiviPara, '[^,]+', 1, LEVEL) IS NOT NULL
	    )
   WHERE valor=nuActividad;

   sbActivSuspeAcom ld_parameter.value_chain%TYPE := dald_parameter.fsbgetvalue_chain('LDC_ACT_SUSPEN_ACOM', NULL);
   sbActivSuspCMed ld_parameter.value_chain%TYPE := dald_parameter.fsbgetvalue_chain('LDC_ACT_SUSPEN_CDM', NULL);
   nuExisteAco NUMBER;
   nuExisteCM NUMBER;
   
   csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.pValidaTipoSuspension';

  BEGIN
    sbresultado := '';

    IF cuActividad%isopen THEN
       CLOSE cuActividad;
    END IF;
    OPEN cuActividad;
    FETCH cuActividad INTO actividad;
    CLOSE cuActividad;
    IF cuValidaActi%isopen THEN
      CLOSE cuValidaActi;
    END IF;
    IF actividad IS NOT NULL THEN
      OPEN cuValidaActi(sbActivSuspeAcom, actividad);
      FETCH cuValidaActi INTO nuExisteAco;
      CLOSE cuValidaActi;
      IF nuExisteAco > 0 THEN
        sbresultado := 'AC';
      ELSE
        IF cuValidaActi%isopen THEN
            CLOSE cuValidaActi;
        END IF;
        OPEN cuValidaActi(sbActivSuspCMed, actividad);
        FETCH cuValidaActi INTO nuExisteCM;
        CLOSE cuValidaActi;
        IF nuExisteCM > 0 THEN
          sbresultado := 'CM';
        ELSE
          sbresultado := '--';
        END IF;
      END IF;
    ELSE
      sbresultado := '--';
    END IF; 
	
	pkg_traza.trace(csbMT_NAME||' sbresultado '||sbresultado, cnuNVLTRC);
	pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
		
    RETURN sbresultado;

  EXCEPTION
    WHEN OTHERS THEN
      sbresultado := '--';
	  pkg_traza.trace(csbMT_NAME||' sbresultado '||sbresultado, cnuNVLTRC);
	  pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      RETURN sbresultado;
  END pValidaTipoSuspension;

  PROCEDURE pProcPlugCambMed IS 
  /**************************************************************************
   Autor       : dsaltarin
   Fecha       : 2020-12-23
   Ticket      : 263
   Proceso     : pProcPlugCambMed
   Descripcion : procedimiento plugin para validar si hubo cambio de medidor

   HISTORIA DE MODIFICACIONES
   FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/  
   nuorden      or_order.order_id%TYPE;
   dtCreac      date;
   nuProdu      pr_product.product_id%TYPE;
   sbmensa      varchar2(4000);
   sbCambio     varchar2(1);
   
   csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.pProcPlugCambMed';

   CURSOR cuGetdatOrden(inuOrden or_order.order_id%TYPE) IS
   SELECT    OA.PRODUCT_ID
        From or_order o, 
             or_order_activity oa 
       WHERE o.order_id = oa.order_id
         AND o.order_id = inuorden;

  BEGIN
  
	   pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	   
       nuorden := pkg_bcordenes.fnuObtenerOTInstanciaLegal; --se obtiene orden que se esta legalizando
       
	   pkg_traza.trace('nuorden' || nuorden, cnuNVLTRC);
       
	   dtCreac := pkg_bcordenes.fdtObtieneFechaCreacion(nuorden);
       
	   pkg_traza.trace('dtCreac' || dtCreac, cnuNVLTRC);

       IF cuGetdatOrden%isopen THEN
          CLOSE cuGetdatOrden;
       END IF;

       OPEN cuGetdatOrden(nuorden);
       FETCH cuGetdatOrden INTO nuProdu;
       IF cuGetdatOrden%NOTFOUND THEN
          sbmensa := 'No existe informacion de la orden ' || TO_CHAR(nuorden);
          Pkg_Error.SetErrorMessage(PKG_ERROR.CNUGENERIC_MESSAGE,
                                           sbmensa);
       END IF;
       CLOSE cuGetdatOrden;

       pkg_traza.trace('nuProdu' || nuProdu, 10);

       sbCambio := fsbValidaCambMed(nuProdu, dtCreac);

       IF sbCambio = 'N' THEN
         LDC_PKPROCSERVVARIOS.PRPROCGENVSI;
       END IF;
	   
	   pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
	   
  END pProcPlugCambMed;


  FUNCTION fsbValidaCambMed(inuProduct_id IN NUMBER,
                            dtFecha       IN date) RETURN varchar2 IS
  /**************************************************************************
   Autor       : dsaltarin
   Fecha       : 2020-12-23
   Ticket      : 263
   Proceso     : fsbValidaCambMed
   Descripcion : funcion que valida si hubo cambio de medidor.

   HISTORIA DE MODIFICACIONES
   FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
    nuCantidad  NUMBER;
    sbCambio    varchar2(1) := 'N';
	
	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.fsbValidaCambMed';

    CURSOR cuCambioMed IS
    SELECT COUNT(1)
    FROM or_order o, or_order_activity a
    WHERE a.order_id=o.order_id
     AND a.product_id=inuProduct_id
     AND o.legalization_Date>=TRUNC(dtFecha)
     AND value1 like 'RETIRAR_UTILITIES>%'
     AND value2 like 'INSTALAR_UTILITIES%';

  BEGIN
  
	pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	
    nuCantidad :=0;

    OPEN cuCambioMed;
    FETCH cuCambioMed INTO nuCantidad;
    CLOSE cuCambioMed;

    IF nuCantidad > 0 THEN
      sbCambio := 'S';
    END IF;
	
	pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
	
    RETURN sbCambio;
	
  END fsbValidaCambMed;

  PROCEDURE pPluginGeneraSusAcoVpm IS
    /**************************************************************************
     Ticket      : 263
     Proceso     : pPluginGeneraSusAcoVpm 
     Descripcion : procedimiento para generar suspension x aco x vpm

     HISTORIA DE MODIFICACIONES
     FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    onuErrorCode NUMBER;
    sbmensa      VARCHAR2(10000);
    nucausalot         NUMBER;
    nuorden          NUMBER;
    nuproducto       NUMBER;
    sbRequestXML     constants_per.tipo_xml_sol%type;
    inuIdAddress     NUMBER;
    inuContactId     NUMBER;
    nuPackageId      mo_packages.package_id%TYPE;
    nuMotiveId       mo_motive.motive_id%TYPE;
    nuUnidad         or_operating_unit.operating_unit_id%TYPE;
    sbcomentario     varchar2(2000);
	
	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.pPluginGeneraSusAcoVpm';

	CURSOR cuDatosSoli(inuOrden or_order.order_id%TYPE) IS
	  SELECT PR.ADDRESS_ID, s.SUSCCLIE, oa.product_id
        FROM PR_PRODUCT PR, SUSCRIPC s, or_order_activity oa
       WHERE PR.SUBSCRIPTION_ID = S.SUSCCODI
         AND PR.PRODUCT_ID = oa.product_id
         AND oa.order_id= inuorden
         AND ROWNUM = 1;


    nuRecepcion       ld_parameter.numeric_value%TYPE :=dald_parameter.fnuGetNumeric_Value('PAR_RECEPTYPEID_CDM',NULL);
    nuTiposuspen      ld_parameter.numeric_value%TYPE :=dald_parameter.fnuGetNumeric_Value('PAR_TIPOSUSP_CDM',NULL);
    nuTipoCausal      ld_parameter.numeric_value%TYPE :=dald_parameter.fnuGetNumeric_Value('PAR_TC_SUSP_CDM',NULL);
    nuCausal          ld_parameter.numeric_value%TYPE :=dald_parameter.fnuGetNumeric_Value('PAR_C_SUSP_ACO',NULL);
  BEGIN

	pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
	
    /*LOGICA: validará si la causal de legalización es de éxito, que el producto se encuentre suspendido por CDM (por calidad de medición) y creará el trámite de reconexión (explicado más adelante), el cual a su vez generará la orden dependiendo de la regla que aplique. Este servicio será un plugin que podrá ser configurado por Datos Maestros*/
    nuorden := pkg_bcordenes.fnuObtenerOTInstanciaLegal;
    nucausalot := pkg_bcordenes.fnuObtieneCausal(nuorden);
    nuUnidad := pkg_bcordenes.fnuObtieneUnidadOperativa(nuorden);

    BEGIN

	   IF(cuDatosSoli%ISOPEN) THEN
    	  CLOSE cuDatosSoli;
	   END IF;

       OPEN cuDatosSoli(nuorden);
	   FETCH cuDatosSoli INTO inuIdAddress, inuContactId, nuproducto;
	   IF cuDatosSoli%NOTFOUND THEN
	      CLOSE cuDatosSoli;
		  RAISE NO_DATA_FOUND;
	   END IF;
	   CLOSE cuDatosSoli;

     EXCEPTION
       WHEN NO_DATA_FOUND THEN
         pkg_traza.trace('Plugin pPluginGeneraSusAcoVpm: No se encontro información de producto');
         RETURN;
       WHEN others THEN
         pkg_traza.trace('Plugin pPluginGeneraSusAcoVpm: Otros: No se encontro información de producto');
         RETURN;
    END;


          sbcomentario   := 'Generada por orden :'||nuorden ||' con causal: '||nucausalot;

		  sbRequestXML:= pkg_xml_soli_calid_medic.getSolicitudSuspensionCLM(nuRecepcion,
																			sbcomentario,
																			nuproducto,
																			inuContactId,
																			nuTiposuspen,
																			nuTipoCausal,
																			nuCausal
																			);

           Api_RegisterRequestByXML(sbRequestXML,
                                    nuPackageId,
                                    nuMotiveId,
                                    onuErrorCode,
                                    sbmensa);

          IF nupackageid IS NULL THEN
            RAISE pkg_Error.Controlled_Error;
          END IF;

	pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
    --finalizamos el proceso

  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
	  pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
      RAISE;
    WHEN OTHERS THEN
      sbmensa := 'Proceso termino con Errores. ' || SQLERRM;
      Pkg_Error.SetError;
	  pkg_traza.trace(csbMT_NAME||' '||sbmensa, cnuNVLTRC);
	  pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      RAISE pkg_Error.Controlled_Error;
  END pPluginGeneraSusAcoVpm;  

  PROCEDURE pPluginGeneraSusAconoCambio IS
    /**************************************************************************
     Ticket      : 263
     Proceso     : pPluginGeneraSusAconoCambio 
     Descripcion : procedimiento para generar suspension x aco x no cambio de medidor

     HISTORIA DE MODIFICACIONES
     FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    onuErrorCode NUMBER;
    sbmensa          VARCHAR2(10000);
    nucausalot       NUMBER;
    nuorden          NUMBER;
    nuproducto       NUMBER;
    sbRequestXML     constants_per.tipo_xml_sol%type;
    inuIdAddress     NUMBER;
    inuContactId     NUMBER;
    nuPackageId      mo_packages.package_id%TYPE;
    nuMotiveId       mo_motive.motive_id%TYPE;
    nuUnidad         or_operating_unit.operating_unit_id%TYPE;
    sbcomentario     varchar2(2000);

    nuRecepcion       ld_parameter.numeric_value%TYPE :=dald_parameter.fnuGetNumeric_Value('PAR_RECEPTYPEID_CDM',NULL);
    nuTiposuspen      ld_parameter.numeric_value%TYPE :=dald_parameter.fnuGetNumeric_Value('PAR_TIPOSUSP_CDM',NULL);
    nuTipoCausal      ld_parameter.numeric_value%TYPE :=dald_parameter.fnuGetNumeric_Value('PAR_TC_SUSP_CDM',NULL);
    nuCausal          ld_parameter.numeric_value%TYPE :=dald_parameter.fnuGetNumeric_Value('PAR_C_SUSP_ACO_XNCAMMED',NULL);
	
	csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.pPluginGeneraSusAconoCambio';

	CURSOR cuDatosSoli(inuOrden or_order.order_id%TYPE) IS
	  SELECT PR.ADDRESS_ID, s.SUSCCLIE, oa.product_id
        FROM PR_PRODUCT PR, SUSCRIPC s, or_order_activity oa
       WHERE PR.SUBSCRIPTION_ID = S.SUSCCODI
         AND PR.PRODUCT_ID = oa.product_id
         AND oa.order_id= inuorden
         AND ROWNUM = 1;

  BEGIN
  
	pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);

    /*LOGICA: validará si la causal de legalización es de éxito, que el producto se encuentre suspendido por CDM (por calidad de medición) y creará el trámite de reconexión (explicado más adelante), el cual a su vez generará la orden dependiendo de la regla que aplique. Este servicio será un plugin que podrá ser configurado por Datos Maestros*/
    nuorden := pkg_bcordenes.fnuObtenerOTInstanciaLegal;
    nucausalot := pkg_bcordenes.fnuObtieneCausal(nuorden);
    nuUnidad := pkg_bcordenes.fnuObtieneUnidadOperativa(nuorden);

    BEGIN

	   IF(cuDatosSoli%ISOPEN) THEN
    	  CLOSE cuDatosSoli;
	   END IF;

       OPEN cuDatosSoli(nuorden);
	   FETCH cuDatosSoli INTO inuIdAddress, inuContactId, nuproducto;
	   IF cuDatosSoli%NOTFOUND THEN
			CLOSE cuDatosSoli;
			RAISE NO_DATA_FOUND;
  	   END IF;
	   CLOSE cuDatosSoli;

     EXCEPTION
       WHEN NO_DATA_FOUND THEN
         pkg_traza.trace('Plugin pPluginGeneraSusAcoVpm: No se encontro información de producto');
         RETURN;
       WHEN others THEN
         pkg_traza.trace('Plugin pPluginGeneraSusAcoVpm: Otros: No se encontro información de producto');
         RETURN;
    END;

          sbcomentario   := 'Generada por orden :'||nuorden ||' con causal: '||nucausalot;


		  sbRequestXML:= pkg_xml_soli_calid_medic.getSolicitudSuspensionCLM(nuRecepcion,
																			sbcomentario,
																			nuproducto,
																			inuContactId,
																			nuTiposuspen,
																			nuTipoCausal,
																			nuCausal
																			);


          Api_RegisterRequestByXML(sbRequestXML,
                                    nuPackageId,
                                    nuMotiveId,
                                    onuErrorCode,
                                    sbmensa);

          IF nupackageid IS NULL THEN
            RAISE pkg_Error.Controlled_Error;
          END IF;

    --finalizamos el proceso
	pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
		RAISE;
    WHEN OTHERS THEN
      sbmensa := 'Proceso termino con Errores. ' || SQLERRM;
      Pkg_Error.SetError;
	  pkg_traza.trace(csbMT_NAME||' '||sbmensa, cnuNVLTRC);
	  pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      RAISE pkg_Error.Controlled_Error;
  END pPluginGeneraSusAconoCambio;

    PROCEDURE pPluginCancSuspCLM IS  
    /**************************************************************************
    Autor       :   jpinedc
    Fecha       :   2023-05-26
    Ticket      :   OSF-1085
    Proceso     :   pPluginCancSuspCLM
    Descripcion :   procedimiento plugin para ingresar un registro para cancelar
                    el proceso de suspensión por cambio de Medidor

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/  
        nuorden      or_order.order_id%TYPE;

        CURSOR cuDatOrden(inuOrden or_order.order_id%TYPE) IS
        SELECT  oa.product_id, oa.package_id, oa.operating_unit_id
        FROM    or_order_activity oa 
        WHERE  oa.order_id = inuorden;

        rcDatOrden  cuDatOrden%ROWTYPE;    
		
		csbMT_NAME  VARCHAR2(70) := csbSP_NAME || '.pPluginCancSuspCLM';

    BEGIN

		pkg_traza.trace(csbMT_NAME,cnuNVLTRC,csbInicio);
		
        nuorden := pkg_bcordenes.fnuObtenerOTInstanciaLegal; --se obtiene orden que se esta legalizando
        
		pkg_traza.trace('nuorden' || nuorden, cnuNVLTRC);

        OPEN  cuDatOrden(nuorden);
        FETCH cuDatOrden INTO rcDatOrden;
        CLOSE cuDatOrden;

        INSERT INTO LDC_LOG_PROCESO_VMP(LOG_PROCESO_VMP_ID,PRODUCTO,SOLICITUD ,UNIDAD_TRABAJO,  FECHA_REGISTRO,MENSAJE_ERROR, proceso,PROCESADO) 
        VALUES (SEQ_LDC_LOG_PROCESO_VMP.NEXTVAL,rcDatOrden.product_id,rcDatOrden.Package_Id,rcDatOrden.operating_unit_id, SYSDATE, NULL,csbPluginCancSuspCLM,'S');

		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
		

    END pPluginCancSuspCLM;

END LDC_BoProcesaOrdVMP;
/

Prompt Otorgando permisos de ejecución a LDC_BoProcesaOrdVMP 
BEGIN
    pkg_Utilidades.prAplicarPermisos('LDC_BoProcesaOrdVMP', 'OPEN' );
END;
/

