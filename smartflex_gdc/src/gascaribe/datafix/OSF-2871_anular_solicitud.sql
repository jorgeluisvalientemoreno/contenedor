column dt new_value vdt
column db new_value vdb
SELECT to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db FROM dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX OSF-2871');
SELECT to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio FROM dual;

DECLARE
/*
    OSF-2871: anular la Solicitud 214343718, orden 326719208 tipo de trabajo
              10450 - SUSPENSION DESDE CM REVISION PERIODICA que se encuentra en estado
              Registrada, para que posteriormente el JOB de RP tome el producto  y
              actualice el tipo de suspensión del producto.

    Autor:    German Dario Guevara Alzate - GlobaMVM
    Fecha:    21/06/2024
*/
    cnuPackage_id           CONSTANT NUMBER       := 214343718;
    cnuCommentType          CONSTANT NUMBER       := 83;
    csbComment              CONSTANT VARCHAR2(90) := 'SE CAMBIA ESTADO A ANULADO POR OSF-2871';

    TYPE t_array_solicitudes IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
    v_array_solicitudes     t_array_solicitudes;

    nuPlanId                wf_instance.instance_id%TYPE;
    osbErrorMessage         VARCHAR2(2000);
    onuErrorCode            NUMBER;
    nuError                 NUMBER;
    nuTotal                 NUMBER;
    nuCont                  NUMBER;

    PACKAGE_IDvar           MO_PACKAGE_CHNG_LOG.PACKAGE_ID%type           := null;
    CUST_CARE_REQUES_NUMvar MO_PACKAGE_CHNG_LOG.CUST_CARE_REQUES_NUM%type := null;
    PACKAGE_TYPE_IDvar      MO_PACKAGE_CHNG_LOG.PACKAGE_TYPE_ID%type      := null;
    CURRENT_TABLE_NAMEvar   MO_PACKAGE_CHNG_LOG.CURRENT_TABLE_NAME%type   := 'MO_PACKAGES';
    CURRENT_EVENT_IDvar     MO_PACKAGE_CHNG_LOG.CURRENT_EVENT_ID%type     := ge_boconstants.UPDATE_;
    CURRENT_EVEN_DESCvar    MO_PACKAGE_CHNG_LOG.CURRENT_EVEN_DESC%type    := 'UPDATE';
    O_MOTIVE_STATUS_IDVar   MO_PACKAGE_CHNG_LOG.o_motive_status_id%type;

    -- Cursor para buscar las solicudes a anular
    CURSOR cuSolicitudes is
        SELECT p2.package_id,
                p2.request_Date,
                p2.motive_status_id,
                p2.user_id,
                p2.comment_,
                p2.cust_care_reques_num,
                p2.package_type_id
        FROM OPEN.mo_packages p
             INNER JOIN OPEN.mo_packages p2 on p2.cust_care_reques_num = to_char(p.cust_care_reques_num)
        WHERE p.package_id = cnuPackage_id
          AND p2.motive_status_id = 13
        ORDER BY  p2.package_id;

    -- Cursor para buscar las ordenes asociadas a la solicitud
    CURSOR cuOrdenes(inuSolicitud number) is
        SELECT o.order_id, order_status_id, o.operating_unit_id
        FROM  open.or_order_activity a, open.or_order o
        WHERE a.order_id = o.order_id
          AND a.package_id = inuSolicitud
          AND a.status != 'F';

    -- Cursor para buscar el flujo asociado a la solicitud
    CURSOR cuErrorFlujo(inuPackage number) is
        SELECT 'MOPRP' forma,
               p.package_id,
               p.motive_status_id,
               p.package_type_id,
               p.request_date,
               el.message,
               null,
               el.date_,
               null codigo_cambiar
        FROM open.mo_executor_log_mot lm,
             open.ge_executor_log     el,
             open.mo_packages         p
        WHERE lm.executor_log_id = el.executor_log_id
          AND p.package_id = lm.package_id
          AND lm.status_exec_log_id = 4
          AND p.package_id = inuPackage
        UNION ALL
        SELECT 'MOPWP' forma,
               p.package_id,
               p.motive_status_id,
               p.package_type_id,
               p.request_date,
               el.message,
               null,
               el.date_,
               null codigo_cambiar
        FROM open.mo_wf_pack_interfac lm,
             open.ge_executor_log     el,
             open.mo_packages         p
        WHERE lm.executor_log_id = el.executor_log_id
          AND p.package_id = lm.package_id
          AND lm.status_activity_id = 4
          AND p.package_id = inuPackage
        UNION ALL
        SELECT 'MOPWM' forma,
               p.package_id,
               p.motive_status_id,
               p.package_type_id,
               p.request_date,
               el.message,
               null,
               el.date_,
               null codigo_cambiar
        FROM open.mo_wf_motiv_interfac lm,
             open.ge_executor_log      el,
             open.mo_packages          p,
             open.mo_motive            m
        WHERE lm.executor_log_id = el.executor_log_id
          AND p.package_id = m.package_id
          AND m.motive_id = lm.motive_id
          AND p.package_id = inuPackage
        UNION ALL
        SELECT 'MOPWC' forma,
               p.package_id,
               p.motive_status_id,
               p.package_type_id,
               p.request_date,
               el.message,
               null,
               el.date_,
               null codigo_cambiar
        FROM open.mo_wf_comp_interfac lm,
             open.ge_executor_log     el,
             open.mo_packages         p,
             open.mo_component        c
        WHERE lm.executor_log_id = el.executor_log_id
          AND p.package_id = c.package_id
          AND c.component_id = lm.component_id
          AND lm.status_activity_id = 4
          AND p.package_id = inuPackage
        UNION ALL
        SELECT 'INRMO/WFEWF' forma,
               p.package_id,
               p.motive_status_id,
               p.package_type_id,
               p.request_date,
               el.message_desc,
               wf.instance_id,
               el.log_date,
               null codigo_cambiar
        FROM open.wf_instance      wf,
             open.wf_exception_log el,
             open.mo_packages      p,
             open.wf_data_external de
        WHERE wf.instance_id = el.instance_id
          AND de.plan_id = wf.plan_id
          AND de.package_id = p.package_id
          AND wf.status_id = 9
          AND el.status = 1
          AND p.package_id = inuPackage
        UNION ALL
        SELECT 'INRMO' forma,
               p.package_id,
               p.motive_status_id,
               p.package_type_id,
               p.request_date,
               last_mess_desc_error,
               w.instance_id,
               i.inserting_date,
               i.interface_history_id codigo_cambiar
        FROM open.in_interface_history i,
             open.wf_instance          w,
             open.mo_packages          p,
             open.wf_data_external     de
        WHERE i.status_id = 9
          AND i.request_number_origi = w.instance_id
          AND de.plan_id = w.plan_id
          AND de.package_id = p.package_id
          AND p.package_id = inuPackage;

    rgErrorFlujo cuErrorFlujo%rowtype;

BEGIN
    dbms_output.put_line('Inicia datafix OSF-2871');
    nuCont := 0;
    nuTotal := 0;
    -- Recorre todas las solicitudes a anular
    FOR reg IN cuSolicitudes LOOP
        nuError := 0;
        nuTotal := nuTotal + 1;
        -- Cambia la Transición
        BEGIN
            dbms_output.put_line('Cambia Transición OSF-2871');
            ldc_pkg_changstatesolici.packageinttransition
            (
                reg.package_id,
                ge_boparameter.fnuget('ANNUL_CAUSAL')
            );
            dbms_output.put_line('Termina Cambia Transición OSF-2871');
        EXCEPTION
            WHEN OTHERS THEN
                rollback;
                nuError := 0;
        END;
        -- Anula ordenes
        FOR regOt IN cuOrdenes(reg.package_id) LOOP
            BEGIN
                dbms_output.put_line('Anula ordenes OSF-2871');
                api_anularorden
                (
                    regOt.order_id,
                    cnuCommentType,
                    csbComment,
                    onuErrorCode,
                    osbErrorMessage
                );
                IF onuErrorCode <> 0 THEN
                    dbms_output.put_line('Error en api_anullorder, Orden: '|| regOt.order_id ||', '|| osbErrorMessage);
                    nuError := 1;
                    rollback;
                END IF;
                dbms_output.put_line('Termina ordenes OSF-2871');
            EXCEPTION
                WHEN OTHERS THEN
                    nuError := 1;
                    rollback;
            END;
        END LOOP;
        -- Anula solicitud
        IF nuError = 0 THEN
            BEGIN
                dbms_output.put_line('Actualiza estados de la solicitud');
                --Cambio estado de la solicitud
                UPDATE OPEN.mo_packages
                SET motive_status_id = dald_parameter.fnuGetNumeric_Value('ID_ESTADO_PKG_ANULADA'), attention_date = sysdate
                WHERE package_id IN (reg.package_id);

                PACKAGE_IDvar           := reg.package_id;
                CUST_CARE_REQUES_NUMvar := damo_packages.fsbgetcust_care_reques_num(reg.package_id,null);
                PACKAGE_TYPE_IDvar      := damo_packages.fnugetpackage_type_id(reg.package_id, null);
                O_MOTIVE_STATUS_IDVar   := DAMO_MOTIVE.FNUGETMOTIVE_STATUS_ID(MO_BCPACKAGES.FNUGETMOTIVEID(reg.package_id));
                -- Guarda el comentario del cambio de la solicitud
                INSERT INTO MO_PACKAGE_CHNG_LOG
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
                    AU_BOSystem.getSystemUserID,
                    AU_BOSystem.getSystemUserMask,
                    ut_session.getTERMINAL,
                    ut_session.getIP,
                    ut_date.fdtSysdate,
                    CURRENT_TABLE_NAMEvar,
                    AU_BOSystem.getSystemProcessName,
                    ut_session.getSESSIONID,
                    CURRENT_EVENT_IDvar,
                    CURRENT_EVEN_DESCvar,
                    ut_session.getProgram || '-' || csbComment,
                    ut_session.getModule,
                    ut_session.GetClientInfo,
                    ut_session.GetAction,
                    MO_BOSEQUENCES.fnuGetSeq_MO_PACKAGE_CHNG_LOG,
                    PACKAGE_IDvar,
                    CUST_CARE_REQUES_NUMvar,
                    PACKAGE_TYPE_IDvar,
                    O_MOTIVE_STATUS_IDVar,
                    dald_parameter.fnuGetNumeric_Value('ID_ESTADO_PKG_ANULADA')
                );
                -- Actualiza MO_MOTIVE
                UPDATE OPEN.mo_motive
                SET annul_date         = SYSDATE,
                    status_change_date = SYSDATE,
                    annul_causal_id    = ge_boparameter.fnuget('ANNUL_CAUSAL'),
                    motive_status_id   = 5,
                    causal_id          = 287,
                    attention_date     = sysdate
                WHERE package_id IN (reg.package_id);

                dbms_output.put_line('Termina Actualiza estados de la solicitud');
                nuCont := nuCont + 1;
            EXCEPTION
                WHEN OTHERS THEN
                    rollback;
                    nuError := 1;
                    dbms_output.put_line('Error anulando solicitud|'||reg.package_id ||'|'||sqlerrm);
            END;
            -- Anula el flujo de la solicitud en caso que exista
            IF nuError = 0 THEN
                COMMIT;
                nuPlanId := 0;
                BEGIN
                    dbms_output.put_line('Obtiene el plan del flujo');
                    nuPlanId := wf_boinstance.fnugetplanid(reg.package_id, 17);
                EXCEPTION
                    WHEN OTHERS THEN
                        rollback;
                        nuError := 1;
                        dbms_output.put_line('Error anulando plan solicitud|'||reg.package_id ||'|'||sqlerrm);
                END;
                -- anula el plan de wf
                IF (NVL(nuPlanId,0) <> 0) THEN
                    BEGIN
                        dbms_output.put_line ('Anula el flujo');
                        mo_boannulment.annulwfplan (nuPlanId);
                        dbms_output.put_line ('Termina anula el flujo');
                    EXCEPTION
                        WHEN OTHERS THEN
                            rollback;
                            nuError := 0;
                    END;
                END IF;
                -- si existe plan valida el flujo
                IF nuError = 0 THEN
                    IF cuErrorFlujo%isopen THEN
                        CLOSE cuErrorFlujo;
                    END IF;
                    -- Valida si la solicitud tiene flujo
                    rgErrorFlujo := null;
                    OPEN cuErrorFlujo(reg.package_id);
                    FETCH cuErrorFlujo INTO rgErrorFlujo;
                    CLOSE cuErrorFlujo;
                    -- Valida si encontro registro
                    IF rgErrorFlujo.package_id is null THEN
                        dbms_output.put_line('Solicitud Anulada Sin Error de Flujo|'||reg.package_id);
                    ELSE
                        IF rgErrorFlujo.forma = 'INRMO' THEN
                            UPDATE in_interface_history i
                            SET i.status_id = 6
                            WHERE i.interface_history_id = rgErrorFlujo.codigo_cambiar;
                        END IF;
                        dbms_output.put_line('Solicitud Anulada Con Error de Flujo|'||reg.package_id);
                    END IF;
                    -- Asienta la transaccion
                    COMMIT;
                END IF;
            END IF;
        END IF;
    END LOOP;

    COMMIT;
    -- Valida el resultado
    IF (nuTotal = 0) THEN
        dbms_output.put_line('Solicitud '||cnuPackage_id||' no existe o no es valida para anular');
    ELSE
        dbms_output.put_line('Solicitudes seleccionas: '||nuTotal||', solicitudes anuladas: '||nuCont);
    END IF;
    dbms_output.put_line('Fin datafix OSF-2871');
END;
/

SELECT to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin FROM dual;
set serveroutput off
quit
/