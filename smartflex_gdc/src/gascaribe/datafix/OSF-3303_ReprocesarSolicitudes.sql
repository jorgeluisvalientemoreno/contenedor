column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare
    --Constantes para el datafix
    csbFormato      constant varchar2(30) := 'dd/mm/yyyy hh24:mi:ss';
    
    --Cursor para extracci�n de data
    cursor cudata(inustatus in MO_EXECUTOR_LOG_MOT.STATUS_EXEC_LOG_ID%TYPE default 1) is 
    select e.executor_log_mot_id,e.package_id,e.LOG_DATE,e.status_exec_log_id, 4 status_exec_log_id_act
    from MO_EXECUTOR_LOG_MOT e
    where package_id in (218725146,218874456)
    and e.status_exec_log_id = inustatus
    and not exists
    (
        select 'x' from wf_data_external w, wf_instance i
        where w.package_id = e.package_id
        and w.plan_id = i.plan_id
        and i.unit_type_id = 100221
        
    )
    ;

    CURSOR cuDataCambio
    (
        inuSolicitud IN  mo_motive.package_id%TYPE
    )
    IS
    SELECT  mo.motive_id,mo.subscription_id,entity_attr_new_val, entity_attr_old_val
    FROM    mo_motive mo, mo_data_change moda 
    WHERE   moda.motive_id = mo.motive_id
    AND     mo.package_id = inuSolicitud
    AND     entity_name = 'SUSCRIPC'; 

    CURSOR cuTipoIdentificacion
    (
        inuCliente  IN ge_subscriber.subscriber_id%TYPE
    )
    IS
    SELECT  origin_value
    FROM    ge_subscriber, ge_equivalenc_values
    WHERE subscriber_id = inuCliente
    AND    equivalence_value_id= ident_type_id
    AND   equivalence_set_id = 57000;

    rcDataCambio    cuDataCambio%ROWTYPE;
    
    nuRowcount  number;
    s_out       varchar2(2000);
    dtfecha     date;
    nuok        number;
    nuerr       number;
    nuoks       number;
    nuerrs      number;
    nuerror     ge_error_log.message_id%TYPE;
    sberror     ge_error_log.description%TYPE; 
    sbcabecera  varchar2(2000);
    sbActualiza varchar2(20);
    nuTipoIdent number;

PROCEDURE AnularSolicitud
IS
    --Solicitudes
    CURSOR cusolicitudes IS
    SELECT
        p2.package_id,
        p2.request_date,
        p2.motive_status_id,
        p2.user_id,
        p2.comment_,
        p2.cust_care_reques_num,
        p2.package_type_id
    FROM
             open.mo_packages p
        INNER JOIN open.mo_packages p2 ON p2.cust_care_reques_num = to_char(p.cust_care_reques_num)
    WHERE
            p.package_id in (218598341,218789283,218819058,218826937,218847129, 218855932,218897815)
        AND p2.motive_status_id = 13
    ORDER BY
        p2.package_id;

    sbcomment               VARCHAR2(4000) := 'Caso para anular Solciitud y sus Ordenes por OSF-3303';
    sbmensaje               VARCHAR2(4000);
    eerrorexception EXCEPTION;
    onuerrorcode            NUMBER(18);
    osberrormessage         VARCHAR2(2000);
    cnucommenttype          CONSTANT NUMBER := 83;
    nuplanid                wf_instance.instance_id%TYPE;
    nuerror                 NUMBER;
    nucommenttype           NUMBER := 1277;
    nuerrorcode             NUMBER;
    sberrormesse            VARCHAR2(4000);
    nuestsolanul            NUMBER := 32;
    nuestmotanul            NUMBER := 5;
    nuestcomanul            NUMBER := 26;
    nucausalanul            NUMBER := ge_boparameter.fnuget('ANNUL_CAUSAL');
    nupackage_id            mo_packages.package_id%type := 216641451;
    
    TYPE t_array_solicitudes IS
        TABLE OF NUMBER INDEX BY BINARY_INTEGER;
    v_array_solicitudes     t_array_solicitudes;
    package_idvar           mo_package_chng_log.package_id%TYPE := NULL;
    cust_care_reques_numvar mo_package_chng_log.cust_care_reques_num%TYPE := NULL;
    package_type_idvar      mo_package_chng_log.package_type_id%TYPE := NULL;
    current_table_namevar   mo_package_chng_log.current_table_name%TYPE := 'MO_PACKAGES';
    current_event_idvar     mo_package_chng_log.current_event_id%TYPE := ge_boconstants.update_;
    current_even_descvar    mo_package_chng_log.current_even_desc%TYPE := 'UPDATE';
    o_motive_status_idvar   mo_package_chng_log.o_motive_status_id%TYPE;
    
    --ordenes
    CURSOR cuordenes (
        nusolicitud NUMBER
    ) IS
    SELECT
        o.order_id,
        order_status_id,
        o.operating_unit_id
    FROM
        open.or_order          o,
        open.or_order_activity a
    WHERE
            a.order_id = o.order_id
        AND a.package_id = nusolicitud
        AND a.status != 'F';
    
    --flujo
    CURSOR cuerrorflujo (
        nusol NUMBER
    ) IS
    SELECT
        'MOPRP' forma,
        p.package_id,
        p.motive_status_id,
        p.package_type_id,
        p.request_date,
        el.message,
        NULL,
        el.date_,
        NULL    codigo_cambiar
    FROM
        open.mo_executor_log_mot lm,
        open.ge_executor_log     el,
        open.mo_packages         p
    WHERE
            lm.executor_log_id = el.executor_log_id
        AND p.package_id = lm.package_id
        AND lm.status_exec_log_id = 4
        AND p.package_id = nusol
    UNION ALL
    SELECT
        'MOPWP' forma,
        p.package_id,
        p.motive_status_id,
        p.package_type_id,
        p.request_date,
        el.message,
        NULL,
        el.date_,
        NULL    codigo_cambiar
    FROM
        open.mo_wf_pack_interfac lm,
        open.ge_executor_log     el,
        open.mo_packages         p
    WHERE
            lm.executor_log_id = el.executor_log_id
        AND p.package_id = lm.package_id
        AND lm.status_activity_id = 4
        AND p.package_id = nusol
    UNION ALL
    SELECT
        'MOPWM' forma,
        p.package_id,
        p.motive_status_id,
        p.package_type_id,
        p.request_date,
        el.message,
        NULL,
        el.date_,
        NULL    codigo_cambiar
    FROM
        open.mo_wf_motiv_interfac lm,
        open.ge_executor_log      el,
        open.mo_packages          p,
        open.mo_motive            m
    WHERE
            lm.executor_log_id = el.executor_log_id
        AND p.package_id = m.package_id
        AND m.motive_id = lm.motive_id
        AND p.package_id = nusol
    UNION ALL
    SELECT
        'MOPWC' forma,
        p.package_id,
        p.motive_status_id,
        p.package_type_id,
        p.request_date,
        el.message,
        NULL,
        el.date_,
        NULL    codigo_cambiar
    FROM
        open.mo_wf_comp_interfac lm,
        open.ge_executor_log     el,
        open.mo_packages         p,
        open.mo_component        c
    WHERE
            lm.executor_log_id = el.executor_log_id
        AND p.package_id = c.package_id
        AND c.component_id = lm.component_id
        AND lm.status_activity_id = 4
        AND p.package_id = nusol
    UNION ALL
    SELECT
        'INRMO/WFEWF' forma,
        p.package_id,
        p.motive_status_id,
        p.package_type_id,
        p.request_date,
        el.message_desc,
        wf.instance_id,
        el.log_date,
        NULL          codigo_cambiar
    FROM
        open.wf_instance      wf,
        open.wf_exception_log el,
        open.mo_packages      p,
        open.wf_data_external de
    WHERE
            wf.instance_id = el.instance_id
        AND de.plan_id = wf.plan_id
        AND de.package_id = p.package_id
        AND wf.status_id = 9
        AND el.status = 1
        AND p.package_id = nusol
    UNION ALL
    SELECT
        'INRMO'                forma,
        p.package_id,
        p.motive_status_id,
        p.package_type_id,
        p.request_date,
        last_mess_desc_error,
        w.instance_id,
        i.inserting_date,
        i.interface_history_id codigo_cambiar
    FROM
        open.in_interface_history i,
        open.wf_instance          w,
        open.mo_packages          p,
        open.wf_data_external     de
    WHERE
            i.status_id = 9
        AND i.request_number_origi = w.instance_id
        AND de.plan_id = w.plan_id
        AND de.package_id = p.package_id
        AND p.package_id = nusol;

    rgerrorflujo            cuerrorflujo%rowtype;
BEGIN
    FOR reg IN cusolicitudes LOOP
        nuerror := 0;
        IF nuerror = 0 THEN
            --1 VALIDACION
            BEGIN
                ldc_pkg_changstatesolici.packageinttransition(reg.package_id, ge_boparameter.fnuget('ANNUL_CAUSAL'));
            EXCEPTION
                WHEN OTHERS THEN
                    ROLLBACK;
                    nuerror := 0;
            END;

            FOR regot IN cuordenes(reg.package_id) LOOP
                BEGIN
                    or_boanullorder.anullorderwithoutval(regot.order_id, sysdate);
                    os_addordercomment(regot.order_id, nucommenttype, sbcomment, nuerrorcode, sberrormesse);
                    IF nuerrorcode = 0 THEN
                        dbms_output.put_line('Se anulo OK orden: ' || regot.order_id);
                    ELSE
                        ROLLBACK;
                        dbms_output.put_line('Error anulando orden: '
                                             || regot.order_id
                                             || ' : '
                                             || sberrormesse);
                        nuerror := 1;
                    END IF;

                EXCEPTION
                    WHEN OTHERS THEN
                        nuerror := 1;
                        ROLLBACK;
                END;
            END LOOP;

            IF nuerror = 0 THEN              

                BEGIN
                    --Cambio estado de la solicitud
                    UPDATE open.mo_packages
                    SET
                        motive_status_id = nuestsolanul
                    WHERE
                        package_id IN ( reg.package_id );

                    package_idvar := reg.package_id;
                    cust_care_reques_numvar := damo_packages.fsbgetcust_care_reques_num(reg.package_id, NULL);
                    package_type_idvar := damo_packages.fnugetpackage_type_id(reg.package_id, NULL);
                    o_motive_status_idvar := damo_motive.fnugetmotive_status_id(mo_bcpackages.fnugetmotiveid(reg.package_id));
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
                        o_motive_status_idvar,
                        nuestsolanul
                    );
                    --SE ANULA EL MOTIVO
                    UPDATE open.mo_motive
                    SET
                        annul_date = sysdate,
                        annul_causal_id = nucausalanul,
                        motive_status_id = nuestmotanul
                    WHERE
                        package_id IN ( reg.package_id );
                    --SE ANULA EL COMPONENTE
                    UPDATE open.mo_component
                    SET
                        annul_date = sysdate,
                        annul_causal_id = nucausalanul,
                        motive_status_id = nuestcomanul
                    WHERE
                        package_id IN ( reg.package_id );

                    COMMIT;
                EXCEPTION
                    WHEN OTHERS THEN
                        ROLLBACK;
                        nuerror := 1;
                        dbms_output.put_line('Error anulando solicitud|'
                                             || reg.package_id
                                             || '|'
                                             || sqlerrm);
                END;

            END IF;

        END IF; ----1 VALIDACION
    END LOOP;  
    
    IF nuerror = 0 or nuerror is null THEN
        
        nuerror := 0;
        BEGIN
            nuplanid := wf_boinstance.fnugetplanid(nupackage_id, 17);
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                nuerror := 1;
                dbms_output.put_line('Error anulando plan solicitud|'
                                     || nupackage_id
                                     || '|'
                                     || sqlerrm);
        END;
        -- anula el plan de wf
        BEGIN
            pkgManejoSolicitudes.prcAnulaFlujo(nuPlanId);
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                nuerror := 1;
                dbms_output.put_line('Error anulando plan solicitud|'
                                     || nupackage_id
                                     || '|'
                                     || sqlerrm);
        END;
    
        IF nuerror = 0 THEN
            IF cuerrorflujo%isopen THEN
                CLOSE cuerrorflujo;
            END IF;
            OPEN cuerrorflujo(nupackage_id);
            FETCH cuerrorflujo INTO rgerrorflujo;
            IF cuerrorflujo%notfound THEN
                COMMIT;
                dbms_output.put_line('SOLICITUD ANULADA SIN ERROR DE FLUJO|' || nupackage_id);
            ELSE
                
                --anula interfaces
                pkgmanejosolicitudes.pfullanullpackages(nupackage_id, sbcomment, onuerrorcode, osberrormessage);
                IF onuerrorcode = 0 THEN
                    COMMIT;
                    dbms_output.put_line('SOLICITUD ANULADA SIN ERROR DE FLUJO|' || nupackage_id);
                ELSE
                    ROLLBACK;
                    dbms_output.put_line('SOLICITUD ANULADA CON ERROR DE FLUJO|'
                                         || nupackage_id
                                         || ' Mensaje Error: '
                                         || osberrormessage);
                END IF;
    
            END IF;
    
            CLOSE cuerrorflujo;
        END IF;
    
    END IF;
    
    
END;
    
begin

    EXECUTE IMMEDIATE 'ALTER TRIGGER PERSONALIZACIONES.TRG_VALIDA_IDENT_CLIENTE DISABLE';
    dtfecha := sysdate;
    nuok := 0;
    nuerr := 0;
    nuoks := 0;
    nuerrs := 0;
    
    sbcabecera := 'Executor_Log_Mot_Id|Package_Id|Log_Date|Status_Exec_Log_Id_Ant|Status_Exec_Log_Id_Act|Actualizado';
    dbms_output.put_line('OSF-3303: Reprocesar Solicitudes');
    dbms_output.put_line('');
    dbms_output.put_line('Actualizaci�n estado MO_EXECUTOR_LOG_MOT');
    dbms_output.put_line('=======================================================');
    dbms_output.put_line(sbcabecera);
    
    for rcdata in cudata loop
    
        begin
            sbActualiza := 'N';
            
            update MO_EXECUTOR_LOG_MOT
            set status_exec_log_id = rcdata.status_exec_log_id_act
            where executor_log_mot_id = rcdata.executor_log_mot_id;
            
            nuRowcount := sql%rowcount;
                
            if nuRowcount = 1 then
                sbActualiza := 'S';
                nuok := nuok + 1;
                commit;
            end if;
                        
            s_out := rcdata.Executor_Log_Mot_Id;
            s_out := s_out||'|'||rcdata.Package_Id;
            s_out := s_out||'|'||to_char(rcdata.Log_Date,csbFormato);
            s_out := s_out||'|'||rcdata.Status_Exec_Log_Id;
            s_out := s_out||'|'||rcdata.Status_Exec_Log_Id_Act;
            s_out := s_out||'|'||sbActualiza;
            
            dbms_output.put_line(s_out);
            
            if sbActualiza = 'N' then
                rollback;
            end if;
            
        exception 
            when others then
                nuerr := nuerr + 1;
                
                s_out := rcdata.Executor_Log_Mot_Id;
                s_out := s_out||'|'||rcdata.Package_Id;
                s_out := s_out||'|'||to_char(rcdata.Log_Date,csbFormato);
                s_out := s_out||'|'||rcdata.Status_Exec_Log_Id;
                s_out := s_out||'|'||rcdata.Status_Exec_Log_Id_Act;
                s_out := s_out||'|'||sbActualiza||'-'||sqlerrm;
                
                dbms_output.put_line(s_out);
                
                rollback;
        end;

	end loop;
    
	sbcabecera := 'Executor_Log_Mot_Id|Package_Id|Reprocesado|Error';
	dbms_output.put_line('');
    dbms_output.put_line('Reprocesamiento Solicitudes');
    dbms_output.put_line('=======================================================');
    dbms_output.put_line(sbcabecera);
    
    for rcdata in cudata(4) loop

        OPEN cuDataCambio(rcdata.Package_Id);
        FETCH cuDataCambio INTO  rcDataCambio;
        CLOSE cuDataCambio;

        OPEN cuTipoIdentificacion(rcDataCambio.entity_attr_new_val);
        FETCH cuTipoIdentificacion INTO nuTipoIdent;
        CLOSE cuTipoIdentificacion;
    
        ge_boinstancecontrol.initinstancemanager;
        ge_boinstancecontrol.createinstance('WORK_INSTANCE');
        ge_boinstancecontrol.addattribute('WORK_INSTANCE', null,'MO_PROCESS','VALUE_1', rcDataCambio.entity_attr_new_val , true);

        ge_boinstancecontrol.createinstance('M_ACTUALIZACION_DE_CLIENTE_100233-2');
        ge_boinstancecontrol.addattribute('M_ACTUALIZACION_DE_CLIENTE_100233-2', null,'MO_PROCESS','VALUE_1', nuTipoIdent, true);

        ge_boinstancecontrol.addattribute('WORK_INSTANCE', null,'PR_SUBSCRIPTION','SUBSCRIPTION_ID', rcDataCambio.subscription_id, true);
        ge_boinstancecontrol.addattribute('M_ACTUALIZACION_DE_CLIENTE_100233-2', null,'MO_PACKAGES','PACKAGE_ID', rcdata.Package_Id, true);  
        ge_boinstancecontrol.addattribute('M_ACTUALIZACION_DE_CLIENTE_100233-2', null,'MO_MOTIVE','MOTIVE_ID', rcDataCambio.motive_id, true);

        begin
            sbActualiza := 'N';
            
            mo_bsexecutor_log_mot.manualsend
            (
                rcdata.Executor_Log_Mot_Id,
                nuerror,sberror
            );
                
            if NVL(nuerror,0) = 0 then
                sbActualiza := 'S';
                nuoks := nuoks + 1;
                commit;
            else
                nuerrs := nuerrs + 1;
                rollback;
            end if;
                        
            s_out := rcdata.Executor_Log_Mot_Id;
            s_out := s_out||'|'||rcdata.Package_Id;
            s_out := s_out||'|'||to_char(rcdata.Log_Date,csbFormato);
            s_out := s_out||'|'||sbActualiza;
            s_out := s_out||'|'||nuerror||'-'||sberror;
            
            dbms_output.put_line(s_out);
            
        exception 
            when others then
                nuerrs := nuerrs + 1;
                
                s_out := rcdata.Executor_Log_Mot_Id;
                s_out := s_out||'|'||rcdata.Package_Id;
                s_out := s_out||'|'||sbActualiza;
                s_out := s_out||'|'||nuerror||'-'||sberror;
                
                dbms_output.put_line(s_out);
                
                rollback;
        end;

	end loop;

    COMMIT;
    
    dbms_output.put_line('=====================================================');
    dbms_output.put_line('Fin Reprocesamiento Solicitudes');
    dbms_output.put_line('Cantidad Registros Actualizados: '||nuok);
    dbms_output.put_line('Cantidad Registros con Error: '||nuerr);
    dbms_output.put_line('Cantidad Solicitudes Reprocesadas: '||nuoks);
    dbms_output.put_line('Cantidad Solicitudes con Error Reprocesamiento: '||nuerrs);

    AnularSolicitud();

    EXECUTE IMMEDIATE 'ALTER TRIGGER PERSONALIZACIONES.TRG_VALIDA_IDENT_CLIENTE ENABLE';
    
exception
    when others then
        sberror := sqlerrm;
        nuerror := sqlcode;
        
        dbms_output.put_line('=====================================================');
        dbms_output.put_line('Fin Reprocesamiento Solicitudes ['||nuerror||'-'||sberror||']');
        dbms_output.put_line('Cantidad Registros Borrados: '||nuok);
        dbms_output.put_line('Cantidad Registros con Error: '||nuerr);
        dbms_output.put_line('Cantidad Solicitudes Reprocesadas: '||nuoks);
        dbms_output.put_line('Cantidad Solicitudes con Error Reprocesamiento: '||nuerrs);
  
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/