COLUMN dt NEW_VALUE vdt

COLUMN db NEW_VALUE vdb

SELECT
    to_char(sysdate, 'yyyymmdd_hh24miss') dt,
    sys_context('userenv', 'db_name')     db
FROM
    dual;

SET SERVEROUTPUT ON SIZE UNLIMITED

EXECUTE dbms_application_info.set_action('APLICANDO DATAFIX');

SELECT
    to_char(sysdate, 'DD-MM-YYYY hh:mi:ss p.m.') fecha_inicio
FROM
    dual;

DECLARE
    CURSOR cusolicitudesatender IS
    SELECT
        mp.package_id solicitud
    FROM
        open.mo_packages mp
    WHERE
            mp.package_type_id = 323
        AND mp.motive_status_id = 13
        AND mp.package_id IN ( 219110723, 210790060 )
    GROUP BY
        mp.package_id;

    rfsolicitudesatender    cusolicitudesatender%rowtype;
    dtfechasistema          DATE := sysdate;
    current_table_namevar   mo_package_chng_log.current_table_name%TYPE := 'MO_PACKAGES';
    current_event_idvar     mo_package_chng_log.current_event_id%TYPE := ge_boconstants.update_;
    current_even_descvar    mo_package_chng_log.current_even_desc%TYPE := 'UPDATE';
    o_motive_status_idvar   mo_package_chng_log.o_motive_status_id%TYPE;
    sbcomment               CONSTANT VARCHAR2(200) := 'SE ATIENDE SOLICITUD CON EL CASO OSF-3800';
    cust_care_reques_numvar mo_package_chng_log.cust_care_reques_num%TYPE := NULL;
    package_type_idvar      mo_package_chng_log.package_type_id%TYPE := NULL;
    package_idvar           mo_package_chng_log.package_id%TYPE := NULL;
BEGIN
    FOR rfsolicitudesatender IN cusolicitudesatender LOOP
        BEGIN
            UPDATE open.mo_packages mp
            SET
                mp.motive_status_id = 14,
                mp.attention_date = dtfechasistema
            WHERE
                    mp.package_id = rfsolicitudesatender.solicitud
                AND mp.motive_status_id = 13;

            UPDATE open.mo_motive mm
            SET
                mm.motive_status_id = 11,
                mm.attention_date = dtfechasistema,
                mm.status_change_date = dtfechasistema
            WHERE
                    mm.package_id = rfsolicitudesatender.solicitud
                AND mm.motive_status_id = 1;
    
            -- Adiciona log de cambio de estado de la solicitud
            package_idvar := rfsolicitudesatender.solicitud;
            cust_care_reques_numvar := damo_packages.fsbgetcust_care_reques_num(package_idvar, NULL);
            package_type_idvar := damo_packages.fnugetpackage_type_id(package_idvar, NULL);
            o_motive_status_idvar := damo_packages.fnugetmotive_status_id(package_idvar, NULL);
            
            INSERT INTO mo_package_chng_log (
                current_user_id,
                current_user_mask,
                current_terminal,
                current_term_ip_addr,
                current_date,
                current_table_name,
                current_exec_name,
                current_session_id,
                current_event_id,
                current_even_desc,
                current_program,
                current_module,
                current_client_info,
                current_action,
                package_chng_log_id,
                package_id,
                cust_care_reques_num,
                package_type_id,
                o_motive_status_id,
                n_motive_status_id
            ) VALUES (
                au_bosystem.getsystemuserid,
                au_bosystem.getsystemusermask,
                ut_session.getterminal,
                ut_session.getip,
                ut_date.fdtsysdate,
                current_table_namevar,
                au_bosystem.getsystemprocessname,
                ut_session.getsessionid,
                current_event_idvar,
                current_even_descvar,
                ut_session.getprogram
                || '-'
                || sbcomment,
                ut_session.getmodule,
                ut_session.getclientinfo,
                ut_session.getaction,
                mo_bosequences.fnugetseq_mo_package_chng_log,
                package_idvar,
                cust_care_reques_numvar,
                package_type_idvar,
                13,
                14
            );

            COMMIT;
            dbms_output.put_line('Se cambia estado de solicitud y motivo ['
                                 || rfsolicitudesatender.solicitud
                                 || ']');
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                dbms_output.put_line('Error. No se cambia esatdo de solicitud y motivo ['
                                     || rfsolicitudesatender.solicitud
                                     || '] - '
                                     || sqlerrm);
        END;
    END LOOP;
END;
/

SELECT
    to_char(sysdate, 'DD-MM-YYYY hh:mi:ss p.m.') fecha_fin
FROM
    dual;

SET SERVEROUTPUT OFF

QUIT
/