column dt new_value vdt
column db new_value vdb
SELECT to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db FROM dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX OSF-3075');
SELECT to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio FROM dual;

DECLARE

    cnuPackage_id           CONSTANT NUMBER       := 106790911;
    cnuCommentType          CONSTANT NUMBER       := 83;
    csbComment              CONSTANT VARCHAR2(90) := 'SE CAMBIA ESTADO A ANULADO POR OSF-3075';

    osbErrorMessage         VARCHAR2(2000);
    onuErrorCode            NUMBER;
    nuError                 NUMBER;

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
    dbms_output.put_line('Inicia datafix OSF-3075');

    nuError := 0;

    -- Anula ordenes
    FOR regOt IN cuOrdenes(cnuPackage_id) LOOP
        BEGIN
            dbms_output.put_line('Anula ordenes OSF-3075');
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
            dbms_output.put_line('Termina ordenes OSF-3075');
        EXCEPTION
            WHEN OTHERS THEN
                nuError := 1;
                rollback;
        END;
    END LOOP;
    -- Anula solicitud
    IF nuError = 0 THEN     
        -- si existe plan valida el flujo
        IF nuError = 0 THEN
            IF cuErrorFlujo%isopen THEN
                CLOSE cuErrorFlujo;
            END IF;
            -- Valida si la solicitud tiene flujo
            rgErrorFlujo := null;
            OPEN cuErrorFlujo(cnuPackage_id);
            FETCH cuErrorFlujo INTO rgErrorFlujo;
            CLOSE cuErrorFlujo;
            -- Valida si encontro registro
            IF rgErrorFlujo.package_id is null THEN
                dbms_output.put_line('Solicitud Anulada Sin Error de Flujo|'||cnuPackage_id);
            ELSE
                IF rgErrorFlujo.forma = 'INRMO' THEN
                    UPDATE in_interface_history i
                    SET i.status_id = 6
                    WHERE i.interface_history_id = rgErrorFlujo.codigo_cambiar;
                END IF;
                dbms_output.put_line('Elimina Error de Flujo|'||cnuPackage_id);
            END IF;
            -- Asienta la transaccion
            COMMIT;
        END IF;
    END IF;


    COMMIT;
    -- Valida el resultado

    dbms_output.put_line('Fin datafix OSF-3075');
END;
/

SELECT to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin FROM dual;
set serveroutput off
quit
/