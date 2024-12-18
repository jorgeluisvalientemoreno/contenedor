CREATE OR REPLACE PACKAGE ADM_PERSON.pkgManejoSolicitudes
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> pkgManejoSolicitudes </Unidad>
    <Autor> felipe.valencia </Autor>
    <Fecha> 17-04-2023 </Fecha>
    <Descripcion> 
        Paquete de gestión de Solicitudes
    </Descripcion>
    <Historial>
           <Modificacion Autor="felipe.valencia" Fecha="17-04-2023" Inc="OSF-937" Empresa="GDC">
               Creación
           </Modificacion>
     </Historial>
     </Package>
    ******************************************************************/

    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------


    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> felipe.valencia </Autor>
    <Fecha> 17-04-2023 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
           <Modificacion Autor="felipe.valencia" Fecha="17-04-2023" Inc="OSF-937" Empresa="GDC"> 
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2;

    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> pAnnulPlanWorkFlow </Unidad>
    <Autor> Luis Felipe Valencia </Autor>
    <Fecha> 17-04-2023 </Fecha>
    <Descripcion> 
        Anula plan de workflow
    </Descripcion>
    <Historial>
           <Modificacion Autor="felipe.valencia" Fecha="17-04-2023" Inc="OSF-937" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    PROCEDURE pAnnulPlanWorkFlow
    (
        inuPackages     IN 		mo_packages.package_id%TYPE
    ) ;

    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> pAnnulRequest </Unidad>
    <Autor> Luis Felipe Valencia </Autor>
    <Fecha> 17-04-2023 </Fecha>
    <Descripcion> 
        Anula la solicitud el motivo y el componente
    </Descripcion>
    <Historial>
           <Modificacion Autor="felipe.valencia" Fecha="17-04-2023" Inc="OSF-937" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    PROCEDURE pAnnulRequest
    (
        inuPackages     IN 		mo_packages.package_id%TYPE,
        inuObservation  IN      mo_package_chng_log.current_even_desc%TYPE
    );
    
    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> pAnnulErrorFlow </Unidad>
    <Autor> Luis Felipe Valencia </Autor>
    <Fecha> 17-04-2023 </Fecha>
    <Descripcion> 
        Anular/atender errores del flujo para no realizar reenvio de peticiones
    </Descripcion>
    <Historial>
           <Modificacion Autor="felipe.valencia" Fecha="17-04-2023" Inc="OSF-937" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    PROCEDURE pAnnulErrorFlow
    (
        inuPackages     IN 		mo_packages.package_id%TYPE
    );
    
    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> pRespondRequest </Unidad>
    <Autor> Luis Felipe Valencia </Autor>
    <Fecha> 17-04-2023 </Fecha>
    <Descripcion> 
        Atiende la solicitud
    </Descripcion>
    <Historial>
           <Modificacion Autor="felipe.valencia" Fecha="17-04-2023" Inc="OSF-937" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    PROCEDURE pRespondRequest
    (
        inuPackages     IN 		mo_packages.package_id%TYPE,
        onuErrorCode    OUT 	ge_error_log.error_log_id%TYPE,
        osbMessageError OUT 	ge_error_log.description%TYPE
    ) ;
    
    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> pFullAnullPackages </Unidad>
    <Autor> Luis Felipe Valencia </Autor>
    <Fecha> 17-04-2023 </Fecha>
    <Descripcion> 
        Proceso que anula la solictud el flujo y su interación
    </Descripcion>
    <Historial>
           <Modificacion Autor="felipe.valencia" Fecha="17-04-2023" Inc="OSF-937" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    PROCEDURE pFullAnullPackages
    (
        inuPackages     IN 		mo_packages.package_id%TYPE,
        inuObservation  IN      mo_package_chng_log.current_even_desc%TYPE,
        onuErrorCode    OUT 	ge_error_log.error_log_id%TYPE,
        osbMessageError OUT 	ge_error_log.description%TYPE
    );
	
	/**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prcAnulaFlujo </Unidad>
    <Autor> Jhon Eduar Erazp</Autor>
    <Fecha> 19-01-2024 </Fecha>
    <Descripcion> 
        Anula el flujo para no realizar reenvio de peticiones
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="19-01-2024" Inc="OSF-1907" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    PROCEDURE prcAnulaFlujo
    (
        inuInstanciaId	IN WF_INSTANCE.INSTANCE_ID%TYPE
    );
END pkgManejoSolicitudes;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.pkgManejoSolicitudes
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> pkgManejoSolicitudes </Unidad>
    <Autor> felipe.valencia </Autor>
    <Fecha> 17-04-2023 </Fecha>
    <Descripcion> 
        Paquete de gestión de Solicitudes
    </Descripcion>
    <Historial>
           <Modificacion Autor="felipe.valencia" Fecha="17-04-2023" Inc="OSF-937" Empresa="GDC">
               Creación
           </Modificacion>
     </Historial>
     </Package>
    ******************************************************************/

    --------------------------------------------
    -- Constantes 
    --------------------------------------------
    csbVERSION          CONSTANT VARCHAR2(10) := 'OSF-1907';
    csbSP_NAME          CONSTANT VARCHAR2(100):= $$PLSQL_UNIT||'.';
    cnuNVLTRC           CONSTANT NUMBER       := pkg_traza.cnuNivelTrzDef;
	csbInicio   		CONSTANT VARCHAR2(35) := pkg_traza.fsbINICIO;
    SBTERMINAL          VARCHAR2(50) 		  := NVL(USERENV('TERMINAL'),'NO TERMINAL');
    CNUSESSIONID        CONSTANT NUMBER(21)   := NVL(USERENV('SESSIONID'),'NO SESSION');	
    
    -----------------------------------
    -- Variables privadas del package
    -----------------------------------
    gsbErrMsg           GE_ERROR_LOG.DESCRIPTION%TYPE;
    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------

    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> felipe.valencia </Autor>
    <Fecha> 17-04-2023 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
           <Modificacion Autor="felipe.valencia" Fecha="17-04-2023" Inc="OSF-937" Empresa="GDC"> 
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2
    IS
    BEGIN
        return CSBVERSION;
    END fsbVersion;
    
    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> pAnnulPlanWorkFlow </Unidad>
    <Autor> Luis Felipe Valencia </Autor>
    <Fecha> 17-04-2023 </Fecha>
    <Descripcion> 
        Anula plan de workflow
    </Descripcion>
    <Historial>
           <Modificacion Autor="felipe.valencia" Fecha="17-04-2023" Inc="OSF-937" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    PROCEDURE pAnnulPlanWorkFlow
    (
        inuPackages     IN 		mo_packages.package_id%TYPE
    ) 
    IS
        nuPlanId            wf_instance.plan_id%TYPE := NULL;
		nuError				NUMBER;  
		sbmensaje   		VARCHAR2(1000);
        -- Nombre de éste método
        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || 'pAnnulPlanWorkFlow';

        CURSOR cuPlanId
        (
            isbExternaId    IN  wf_instance.external_id%TYPE,
            inuEntityId     IN  wf_instance.entity_id%TYPE
        )
        IS
        SELECT  plan_id
        FROM    wf_instance
        WHERE   external_id = isbExternaId
        AND     entity_id = inuEntityId
        AND     initial_date IS NOT NULL
        ORDER BY initial_date DESC; 
    BEGIN
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuPackages: ' || inuPackages, cnuNVLTRC);
        
        OPEN cuPlanId(inuPackages, 17);
        FETCH cuPlanId INTO nuPlanId;
        CLOSE cuPlanId;
        
        IF (nuPlanId IS NOT NULL) THEN
            mo_boannulment.annulwfplan(nuPlanId);
        END IF;

        pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_error.setError;
		pkg_Error.getError(nuError, sbmensaje);
		pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
		pkg_traza.trace(csbSP_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC); 
        RAISE pkg_error.CONTROLLED_ERROR;
    WHEN others THEN
        pkg_Error.setError;
		pkg_Error.getError(nuError, sbmensaje);
		pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
		pkg_traza.trace(csbSP_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR); 
		RAISE pkg_Error.Controlled_Error;
    END pAnnulPlanWorkFlow;
    
    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> pAnnulRequest </Unidad>
    <Autor> Luis Felipe Valencia </Autor>
    <Fecha> 17-04-2023 </Fecha>
    <Descripcion> 
        Anula la solicitud el motivo y el componente
    </Descripcion>
    <Historial>
           <Modificacion Autor="felipe.valencia" Fecha="17-04-2023" Inc="OSF-937" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    PROCEDURE pAnnulRequest
    (
        inuPackages     IN 		mo_packages.package_id%TYPE,
        inuObservation  IN      mo_package_chng_log.current_even_desc%TYPE
    ) 
    IS
        nuPackageID                 mo_package_chng_log.PACKAGE_ID%TYPE := NULL;
        nuCustCareRequesNum         mo_package_chng_log.CUST_CARE_REQUES_NUM%TYPE := NULL;
        nuPackageTypeId             mo_package_chng_log.PACKAGE_TYPE_ID%TYPE := NULL;
        sbCurrentTableName          mo_package_chng_log.CURRENT_TABLE_NAME%TYPE := 'MO_PACKAGES';
        nuCurrentEventId            mo_package_chng_log.CURRENT_EVENT_ID%TYPE := 2;
        sbCurrentEvenDesc           mo_package_chng_log.CURRENT_EVEN_DESC%TYPE:= 'UPDATE';
        nuOMotiveStatusId           mo_package_chng_log.o_motive_status_id%TYPE;
        nuMotiveId                  mo_motive.motive_id%TYPE := NULL;
		nuError						NUMBER;  
		sbmensaje   				VARCHAR2(1000);
        sbModule                    VARCHAR2(250);
        sbAction                    VARCHAR2(250);
        sbClientInfo                VARCHAR2(250);
        
        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || 'pAnnulRequest';

        CURSOR cuMotive
        (
            inuRequestId    IN mo_packages.package_id%TYPE
        )
        IS
        SELECT  motive_id 
        FROM    mo_motive
        WHERE   package_id =inuRequestId
        AND     ROWNUM = 1;        
    BEGIN
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuPackages: ' 	|| inuPackages || chr(10) ||
						'inuObservation: '  || inuObservation, cnuNVLTRC);

        DBMS_APPLICATION_INFO.READ_MODULE(sbModule,sbAction);
        DBMS_APPLICATION_INFO.READ_CLIENT_INFO(sbClientInfo);
        
        --Inserta en el log de cambio de la solicitud
        nuPackageID := inuPackages;
        nuCustCareRequesNum := ldc_bcconsgenerales.fsbValorColumna('OPEN.MO_PACKAGES','CUST_CARE_REQUES_NUM','PACKAGE_ID', nuPackageID);
        nuPackageTypeId := ldc_bcconsgenerales.fsbValorColumna('OPEN.MO_PACKAGES','PACKAGE_TYPE_ID','PACKAGE_ID', nuPackageID); 
        
        OPEN cuMotive(nuPackageID);
        FETCH cuMotive INTO nuMotiveId;
        CLOSE cuMotive;
        
        nuOMotiveStatusId := ldc_bcconsgenerales.fsbValorColumna('OPEN.MO_MOTIVE','MOTIVE_STATUS_ID','MOTIVE_ID', nuMotiveId);
        
        INSERT INTO mo_package_chng_log
        (
            CURRENT_USER_ID,
            CURRENT_USER_MASK,
            CURRENT_TERMINAL,
            CURRENT_TERM_IP_ADDR,
            CURRENT_DATE,
            CURRENT_TABLE_NAME,
            CURRENT_EXEC_NAME,
            CURRENT_SESSION_ID,
            CURRENT_EVENT_ID,
            CURRENT_EVEN_DESC,
            CURRENT_PROGRAM,
            CURRENT_MODULE,
            CURRENT_CLIENT_INFO,
            CURRENT_ACTION,
            PACKAGE_CHNG_LOG_ID,
            PACKAGE_ID,
            CUST_CARE_REQUES_NUM,
            PACKAGE_TYPE_ID,
            O_MOTIVE_STATUS_ID,
            N_MOTIVE_STATUS_ID
        )
        VALUES 
        (
            pkg_session.getUserId,
            pkg_session.getUser,
            SBTERMINAL,
            pkg_session.getIP,
            ldc_boConsGenerales.fdtGetSysDate,
            sbCurrentTableName,
            pkg_error.getApplication,
            CNUSESSIONID,
            nuCurrentEventId,
            sbCurrentEvenDesc,
            pkg_session.getProgram||'-'|| inuObservation,
            sbModule,
            sbClientInfo,
            sbAction,
            SEQ_MO_PACKAGE_CHNG_LOG.nextval,
            nuPackageID,
            nuCustCareRequesNum,
            nuPackageTypeId,
            nuOMotiveStatusId,
            ldc_bcconsgenerales.fsbValorColumna('OPEN.LD_PARAMETER','NUMERIC_VALUE','PARAMETER_ID', 'ID_ESTADO_PKG_ANULADA')
        );
                                                
        -- Cambio estado de la solicitud
        UPDATE  mo_packages
        SET     motive_status_id = ldc_bcconsgenerales.fsbValorColumna
                                    (
                                        'OPEN.LD_PARAMETER',
                                        'NUMERIC_VALUE',
                                        'PARAMETER_ID', 
                                        'ID_ESTADO_PKG_ANULADA'
                                    )
        WHERE   package_id IN (nuPackageID);

        --Anula motivo
        UPDATE  mo_motive
        SET     annul_date = SYSDATE,
                status_change_date = SYSDATE,
                annul_causal_id = ldc_bcconsgenerales.fsbValorColumna
                                    (
                                        'OPEN.GE_PARAMETER',
                                        'VALUE',
                                        'PARAMETER_ID', 
                                        'ANNUL_CAUSAL'
                                    ),
                motive_status_id = 5
        WHERE package_id IN (nuPackageID);

        --Se Anula el componente
        UPDATE  mo_component
        SET     annul_date = SYSDATE,
                annul_causal_id = ldc_bcconsgenerales.fsbValorColumna
                                    (
                                        'OPEN.GE_PARAMETER',
                                        'VALUE',
                                        'PARAMETER_ID', 
                                        'ANNUL_CAUSAL'
                                    ),
        motive_status_id = 26
        WHERE package_id IN (nuPackageID);

        pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_error.setError;
		pkg_Error.getError(nuError, sbmensaje);
		pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
		pkg_traza.trace(csbSP_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC); 
        RAISE pkg_error.CONTROLLED_ERROR;
    WHEN others THEN
        pkg_Error.setError;
		pkg_Error.getError(nuError, sbmensaje);
		pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
		pkg_traza.trace(csbSP_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR); 
		RAISE pkg_Error.Controlled_Error;
    END pAnnulRequest;
    
    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> pAnnulErrorFlow </Unidad>
    <Autor> Luis Felipe Valencia </Autor>
    <Fecha> 17-04-2023 </Fecha>
    <Descripcion> 
        Anular/atender errores del flujo para no realizar reenvio de peticiones
    </Descripcion>
    <Historial>
           <Modificacion Autor="felipe.valencia" Fecha="17-04-2023" Inc="OSF-937" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    PROCEDURE pAnnulErrorFlow
    (
        inuPackages     IN 		mo_packages.package_id%TYPE
    ) 
    IS
        csbMT_NAME  	VARCHAR2(70) := csbSP_NAME || 'pAnnulErrorFlow';
		
		nuError				NUMBER;  
		sbmensaje   		VARCHAR2(1000);
        
        CURSOR cuErrorFlow
        (
            inuRequest  IN  mo_packages.package_id%TYPE
        ) 
        IS
        SELECT 'MOPRP' FORMA,
                P.PACKAGE_ID,
                P.MOTIVE_STATUS_ID,
                P.PACKAGE_TYPE_ID,
                P.REQUEST_DATE,
                EL.MESSAGE,
                NULL,
                EL.date_,
                LM.EXECUTOR_LOG_MOT_ID CODIGO_CAMBIAR1,
                NULL CODIGO_CAMBIAR2
        FROM    MO_EXECUTOR_LOG_MOT LM,
                GE_EXECUTOR_LOG     EL,
                MO_PACKAGES         P
        WHERE   LM.EXECUTOR_LOG_ID = EL.EXECUTOR_LOG_ID
        AND     P.PACKAGE_ID = LM.PACKAGE_ID
        AND     LM.STATUS_EXEC_LOG_ID = 4
        AND     P.PACKAGE_ID = inuRequest
        UNION ALL
        SELECT  'MOPWP' FORMA,
                P.PACKAGE_ID,
                P.MOTIVE_STATUS_ID,
                P.PACKAGE_TYPE_ID,
                P.REQUEST_DATE,
                EL.MESSAGE,
                NULL,
                EL.date_,
                LM.WF_PACK_INTERFAC_ID CODIGO_CAMBIAR1,
        NULL    CODIGO_CAMBIAR2
        FROM    MO_WF_PACK_INTERFAC LM,
                GE_EXECUTOR_LOG     EL,
                MO_PACKAGES         P
        WHERE   LM.EXECUTOR_LOG_ID = EL.EXECUTOR_LOG_ID
        AND     P.PACKAGE_ID = LM.PACKAGE_ID
        AND     LM.STATUS_ACTIVITY_ID = 4
        AND     P.PACKAGE_ID = inuRequest
        UNION ALL
        SELECT  'MOPWM' FORMA,
                P.PACKAGE_ID,
                P.MOTIVE_STATUS_ID,
                P.PACKAGE_TYPE_ID,
                P.REQUEST_DATE,
                EL.MESSAGE,
                NULL,
                EL.date_,
                WF_MOTIV_INTERFAC_ID CODIGO_CAMBIAR1,
                NULL CODIGO_CAMBIAR2
        FROM    MO_WF_MOTIV_INTERFAC LM,
                GE_EXECUTOR_LOG      EL,
                MO_PACKAGES          P,
                MO_MOTIVE            M
        WHERE   LM.EXECUTOR_LOG_ID = EL.EXECUTOR_LOG_ID
        AND     P.PACKAGE_ID = M.PACKAGE_ID
        AND     M.MOTIVE_ID = LM.MOTIVE_ID
        AND     LM.STATUS_ACTIVITY_ID = 4
        AND     P.PACKAGE_ID = inuRequest
        UNION ALL
        SELECT  'MOPWC' FORMA,
                P.PACKAGE_ID,
                P.MOTIVE_STATUS_ID,
                P.PACKAGE_TYPE_ID,
                P.REQUEST_DATE,
                EL.MESSAGE,
                NULL,
                EL.date_,
                WF_COMP_INTERFAC_ID CODIGO_CAMBIAR1,
                NULL CODIGO_CAMBIAR2
        FROM    MO_WF_COMP_INTERFAC LM,
                GE_EXECUTOR_LOG     EL,
                MO_PACKAGES         P,
                MO_COMPONENT        C
        WHERE   LM.EXECUTOR_LOG_ID = EL.EXECUTOR_LOG_ID
        AND     P.PACKAGE_ID = C.PACKAGE_ID
        AND     C.COMPONENT_ID = LM.COMPONENT_ID
        AND     LM.STATUS_ACTIVITY_ID = 4
        AND     P.PACKAGE_ID = inuRequest
        UNION ALL
        SELECT  'INRMO/WFEWF' FORMA,
                P.PACKAGE_ID,
                P.MOTIVE_STATUS_ID,
                P.PACKAGE_TYPE_ID,
                P.REQUEST_DATE,
                EL.MESSAGE_DESC,
                WF.INSTANCE_ID,
                EL.LOG_DATE,
                WF.INSTANCE_ID CODIGO_CAMBIAR1,
                EL.EXCEPTION_LOG_ID CODIGO_CAMBIAR2
        FROM    WF_INSTANCE      WF,
                WF_EXCEPTION_LOG EL,
                MO_PACKAGES      P,
                WF_DATA_EXTERNAL DE
        WHERE   WF.INSTANCE_ID = EL.INSTANCE_ID
        AND     DE.PLAN_ID = WF.PLAN_ID
        AND     DE.PACKAGE_ID = P.PACKAGE_ID
        AND     WF.STATUS_ID IN (9, 14)
        AND     EL.STATUS = 1
        AND     P.PACKAGE_ID = inuRequest
        UNION ALL
        SELECT  'INRMO' FORMA,
                P.PACKAGE_ID,
                P.MOTIVE_STATUS_ID,
                P.PACKAGE_TYPE_ID,
                P.REQUEST_DATE,
                LAST_MESS_DESC_ERROR,
                W.INSTANCE_ID,
                I.INSERTING_DATE,
                I.INTERFACE_HISTORY_ID CODIGO_CAMBIAR1,
                NULL CODIGO_CAMBIAR2
        FROM    IN_INTERFACE_HISTORY I,
                WF_INSTANCE          W,
                MO_PACKAGES          P,
                WF_DATA_EXTERNAL     DE
        WHERE   I.STATUS_ID = 9
        AND     I.REQUEST_NUMBER_ORIGI = W.INSTANCE_ID
        AND     DE.PLAN_ID = W.PLAN_ID
        AND     DE.PACKAGE_ID = P.PACKAGE_ID
        AND     P.PACKAGE_ID = inuRequest;

        rcErrorFlow     cuErrorFlow%ROWTYPE;
        
    BEGIN
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuPackages: ' || inuPackages, cnuNVLTRC);

        IF (cuErrorFlow%isopen) THEN
            CLOSE cuErrorFlow;
        END IF;
        
        OPEN cuErrorFlow(inuPackages);
        FETCH cuErrorFlow INTO rcErrorFlow;		
        
        IF (cuErrorFlow%notfound) THEN
            pkg_traza.trace('Sin errores a atender', cnuNVLTRC);
			
        ELSE
			pkg_traza.trace('Se encontrarón errores para atender', cnuNVLTRC);
            CASE rcErrorFlow.FORMA
                WHEN 'MOPRP' THEN
                    UPDATE MO_EXECUTOR_LOG_MOT i
                    SET i.status_exec_log_id = 3 -- Procesado
                    WHERE i.EXECUTOR_LOG_MOT_ID = rcErrorFlow.CODIGO_CAMBIAR1;
                WHEN 'MOPWP' THEN
                    UPDATE MO_WF_PACK_INTERFAC i
                    SET i.status_activity_id = 3 -- Atendida
                    WHERE i.WF_PACK_INTERFAC_ID = rcErrorFlow.CODIGO_CAMBIAR1;
                    WHEN 'MOPWM' THEN

                    UPDATE MO_WF_MOTIV_INTERFAC i
                    SET i.status_activity_id = 3 -- Atendida
                    WHERE i.WF_MOTIV_INTERFAC_ID = rcErrorFlow.CODIGO_CAMBIAR1;
                WHEN 'MOPWC' THEN
                    UPDATE MO_WF_COMP_INTERFAC i
                    SET i.status_activity_id = 3 -- Atendida
                    WHERE i.WF_COMP_INTERFAC_ID = rcErrorFlow.CODIGO_CAMBIAR1;
                WHEN 'INRMO/WFEWF' THEN
                    UPDATE WF_INSTANCE i
                    SET i.status_id = 8 -- Cancelada
                    WHERE i.INSTANCE_ID = rcErrorFlow.CODIGO_CAMBIAR1;

                    UPDATE WF_EXCEPTION_LOG i
                    SET i.status = 2 -- Resuelta
                    WHERE i.EXCEPTION_LOG_ID = rcErrorFlow.CODIGO_CAMBIAR2;
                WHEN 'INRMO' THEN
                    UPDATE IN_INTERFACE_HISTORY i
                    SET i.status_id = 6 -- Mensaje cancelado
                    WHERE i.INTERFACE_HISTORY_ID = rcErrorFlow.CODIGO_CAMBIAR1;
            END CASE;
        END IF;
        CLOSE cuErrorFlow;
        pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_error.setError;
		pkg_Error.getError(nuError, sbmensaje);
		pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
		pkg_traza.trace(csbSP_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC); 
        RAISE pkg_error.CONTROLLED_ERROR;
    WHEN others THEN
        pkg_Error.setError;
		pkg_Error.getError(nuError, sbmensaje);
		pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
		pkg_traza.trace(csbSP_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR); 
		RAISE pkg_Error.Controlled_Error;
    END pAnnulErrorFlow;
    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> pRespondRequest </Unidad>
    <Autor> Luis Felipe Valencia </Autor>
    <Fecha> 17-04-2023 </Fecha>
    <Descripcion> 
        Atiende la solicitud
    </Descripcion>
    <Historial>
           <Modificacion Autor="felipe.valencia" Fecha="17-04-2023" Inc="OSF-937" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    PROCEDURE pRespondRequest
    (
        inuPackages     IN 		mo_packages.package_id%TYPE,
        onuErrorCode    OUT 	ge_error_log.error_log_id%TYPE,
        osbMessageError OUT 	ge_error_log.description%TYPE
    ) 
    IS    
        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || 'pRespondRequest';
    BEGIN
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuPackages: ' || inuPackages, cnuNVLTRC);
        
        onuErrorCode := 0;
        osbMessageError := NULL; 
        
        UPDATE mo_packages
        SET     motive_status_id = 14
        WHERE   package_id IN (inuPackages);

        UPDATE  mo_motive
        SET     annul_date = SYSDATE,
                status_change_date = SYSDATE,
                motive_status_id = 23
        WHERE   package_id IN (inuPackages);
        
        UPDATE  MO_COMPONENT
        SET     annul_date         = SYSDATE,
                motive_status_id   = 26
        WHERE   package_id IN (inuPackages);

        pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_Error.setError;
        pkg_Error.geterror(onuErrorCode, osbMessageError);
		pkg_traza.trace('onuCodigoError: ' || onuErrorCode, cnuNVLTRC);
		pkg_traza.trace('osbMessageError: ' || osbMessageError, cnuNVLTRC);
		pkg_traza.trace(csbSP_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC); 
        RAISE pkg_error.CONTROLLED_ERROR;
    WHEN others THEN
        pkg_Error.setError;
        pkg_Error.geterror(onuErrorCode, osbMessageError);
		pkg_traza.trace('onuCodigoError: '||onuErrorCode, cnuNVLTRC);
		pkg_traza.trace('osbMessageError: '||osbMessageError, cnuNVLTRC);
		pkg_traza.trace(csbSP_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR); 
        RAISE pkg_error.CONTROLLED_ERROR;
    END pRespondRequest;    

    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> pFullAnullPackages </Unidad>
    <Autor> Luis Felipe Valencia </Autor>
    <Fecha> 17-04-2023 </Fecha>
    <Descripcion> 
        Proceso que anula la solictud el flujo y su interación
    </Descripcion>
    <Historial>
           <Modificacion Autor="felipe.valencia" Fecha="17-04-2023" Inc="OSF-937" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    PROCEDURE pFullAnullPackages
    (
        inuPackages     IN 		mo_packages.package_id%TYPE,
        inuObservation  IN      mo_package_chng_log.current_even_desc%TYPE,
        onuErrorCode    OUT 	ge_error_log.error_log_id%TYPE,
        osbMessageError OUT 	ge_error_log.description%TYPE
    ) 
    IS
        csbMT_NAME  VARCHAR2(70) := csbSP_NAME || 'pFullAnullPackages';
		
        CURSOR cuGetDataPackages
        (
            inuRequest IN mo_packages.package_id%TYPE
        )
        IS
        SELECT  p2.package_id,
                p2.request_Date,
                p2.motive_status_id,
                p2.user_id,
                p2.comment_,
                p2.cust_care_reques_num,
                p2.package_type_id
        FROM    mo_packages p
        INNER JOIN mo_packages p2 on p2.cust_care_reques_num = to_char(p.cust_care_reques_num)
        WHERE   p.package_id = inuRequest
        AND     p2.motive_status_id = 13
        ORDER BY  p2.package_id;
    BEGIN
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuPackages: '    || inuPackages || chr(10) ||
						'inuObservation: ' || inuObservation, cnuNVLTRC);
        
        onuErrorCode := 0;
        osbMessageError := NULL; 
        
        FOR reg IN cuGetDataPackages(inuPackages) LOOP
            --Anula el plan de flujo de trabajo
            pAnnulPlanWorkFlow(reg.package_id);
            
            --Anula la solicitud, el motivo y el componente
            pAnnulRequest(reg.package_id,inuObservation);
            
            --Anula y atiende los errores del flujo
            pAnnulErrorFlow(reg.package_id); 
        END LOOP;
        
        pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_Error.setError;
        pkg_Error.geterror(onuErrorCode, osbMessageError);
		pkg_traza.trace('onuCodigoError: '||onuErrorCode, cnuNVLTRC);
		pkg_traza.trace('osbMessageError: '||osbMessageError, cnuNVLTRC);
		pkg_traza.trace(csbSP_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC); 
    WHEN others THEN
        pkg_Error.setError;
        pkg_Error.geterror(onuErrorCode, osbMessageError);
		pkg_traza.trace('onuCodigoError: '||onuErrorCode, cnuNVLTRC);
		pkg_traza.trace('osbMessageError: '||osbMessageError, cnuNVLTRC);
		pkg_traza.trace(csbSP_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR); 
    END pFullAnullPackages;
	
	/**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prcAnulaFlujo </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 19-01-2024 </Fecha>
    <Descripcion> 
        Anula el flujo para no realizar reenvio de peticiones
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="19-01-2024" Inc="OSF-1907" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    PROCEDURE prcAnulaFlujo
    (
        inuInstanciaId	IN WF_INSTANCE.INSTANCE_ID%TYPE
    )
    IS
		csbMT_NAME  VARCHAR2(70) := csbSP_NAME || 'prcAnulaFlujo';

        nuError				NUMBER;  
		sbmensaje   		VARCHAR2(1000);
		rcInstancia     	DAWF_INSTANCE.STYWF_INSTANCE;
        nuSolicitudId   	MO_PACKAGES.PACKAGE_ID%TYPE;
		tbSolicitudAssoc	DAMO_PACKAGES_ASSO.TYTBMO_PACKAGES_ASSO;
		nuFatherIdx     	BINARY_INTEGER;
        nuPadrePlanId  		WF_INSTANCE.INSTANCE_ID%TYPE;
        
    BEGIN
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		
		pkg_traza.trace('inuInstanciaId: ' || inuInstanciaId, cnuNVLTRC);
		
		-- Anulo el flujo de la solicitud
		WF_BOINSTANCE.UPDANNULPLANSTATUS(inuInstanciaId);
        
        -- Obtiene información de la instancia
		rcInstancia := DAWF_INSTANCE.FRCGETRECORD(inuInstanciaId);
        
        -- Obtiene la solicitud de la instancia
		nuSolicitudId := MO_BOPACKAGES.FNUGETPACKIDBYENTITY(rcInstancia.EXTERNAL_ID, rcInstancia.ENTITY_ID);
		pkg_traza.trace('nuSolicitudId: ' || nuSolicitudId, cnuNVLTRC);
        
        -- Obtiene si tiene solicitud asociada
		tbSolicitudAssoc := MO_BCPACKAGES_ASSO.FTBPACKASSOBYPACKID(nuSolicitudId);
        nuFatherIdx := tbSolicitudAssoc.FIRST;
        WHILE (nuFatherIdx IS NOT NULL) LOOP
            
            IF (tbSolicitudAssoc(nuFatherIdx).ANNUL_DEPENDENT = CC_BOCONSTANTS.CSBSI) THEN

				pkg_traza.trace('Anula la solicitud asociada: ' || tbSolicitudAssoc(nuFatherIdx).PACKAGE_ID_ASSO, cnuNVLTRC);
                
                nuPadrePlanId := WF_BOINSTANCE.FNUGETPLANID(tbSolicitudAssoc(nuFatherIdx).PACKAGE_ID_ASSO, 17);
				
				pkg_traza.trace('nuPadrePlanId: ' || nuPadrePlanId, cnuNVLTRC);
				
				IF (nuPadrePlanId IS NOT NULL) THEN
					prcAnulaFlujo(nuPadrePlanId);
				END IF;

            END IF;
            nuFatherIdx := tbSolicitudAssoc.NEXT(nuFatherIdx);
        END LOOP;
        
		pkg_traza.trace(csbSP_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_error.setError;
		pkg_Error.getError(nuError, sbmensaje);
		pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
		pkg_traza.trace(csbSP_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC); 
        RAISE pkg_error.CONTROLLED_ERROR;
    WHEN others THEN
        pkg_Error.setError;
		pkg_Error.getError(nuError, sbmensaje);
		pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
		pkg_traza.trace(csbSP_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR); 
		RAISE pkg_Error.Controlled_Error;
    END prcAnulaFlujo;
END pkgManejoSolicitudes;
/
BEGIN
pkg_utilidades.prAplicarPermisos(upper('pkgManejoSolicitudes'),'ADM_PERSON'); 
END;
/