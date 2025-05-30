pkgManejoSolicitudes.pAnnulErrorFlow;

 PROCEDURE pAnnulErrorFlow
    (
        inuPackages     IN 		mo_packages.package_id%TYPE
    ) 
    IS
        csbMT_NAME      VARCHAR2(30) := 'pAnnulErrorFlow';
        
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
        ut_trace.trace('Inicio ' || csbSP_NAME||csbMT_NAME, cnuNVLTRC);
        ut_trace.trace('inuPackages: '||inuPackages, 10);

        IF (cuErrorFlow%isopen) THEN
            CLOSE cuErrorFlow;
        END IF;
        
        OPEN cuErrorFlow(inuPackages);
        FETCH cuErrorFlow INTO rcErrorFlow;

        
        ut_trace.trace('Ejecu ' || csbSP_NAME||csbMT_NAME, cnuNVLTRC);
        
        IF (cuErrorFlow%notfound) THEN
            ut_trace.trace('Sin errores a atender', 2);
        ELSE
            ut_trace.trace('Se encontrarón errores para atender', 10);

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
                    UPDATE OPEN.WF_INSTANCE i
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
        ut_trace.trace('Fin ' || csbSP_NAME||csbMT_NAME, cnuNVLTRC);

    EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_error.setError;
        RAISE pkg_error.CONTROLLED_ERROR;
    WHEN others THEN
        pkg_Error.setError;
        RAISE pkg_error.CONTROLLED_ERROR;
    END pAnnulErrorFlow;
