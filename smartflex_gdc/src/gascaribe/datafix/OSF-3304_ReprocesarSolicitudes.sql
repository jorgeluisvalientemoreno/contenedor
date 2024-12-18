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
    where package_id in (
                         218746078,
                        218725146,
                        218708574,
                        218660541,
                        218653263,
                        218611492,
                        218603095

    )
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
    
begin
    dtfecha := sysdate;
    nuok := 0;
    nuerr := 0;
    nuoks := 0;
    nuerrs := 0;
    
    sbcabecera := 'Executor_Log_Mot_Id|Package_Id|Log_Date|Status_Exec_Log_Id_Ant|Status_Exec_Log_Id_Act|Actualizado';
    dbms_output.put_line('OSF-3267: Reprocesar Solicitudes');
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
    
    dbms_output.put_line('=====================================================');
    dbms_output.put_line('Fin Reprocesamiento Solicitudes');
    dbms_output.put_line('Cantidad Registros Actualizados: '||nuok);
    dbms_output.put_line('Cantidad Registros con Error: '||nuerr);
    dbms_output.put_line('Cantidad Solicitudes Reprocesadas: '||nuoks);
    dbms_output.put_line('Cantidad Solicitudes con Error Reprocesamiento: '||nuerrs);
    
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