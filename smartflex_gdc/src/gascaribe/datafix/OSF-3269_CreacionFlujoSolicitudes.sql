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
    where package_id in (217625077)
    and e.status_exec_log_id = inustatus
    and not exists
    (
        select 'x' from wf_data_external w, wf_instance i
        where w.package_id = e.package_id
        and w.plan_id = i.plan_id
        and i.unit_type_id = 100220
        
    )
    ;
    
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

    
begin
    dtfecha := sysdate;
    nuok := 0;
    nuerr := 0;
    nuoks := 0;
    nuerrs := 0;

    dbms_output.put_line('OSF-3269: Reprocesar Solicitudes');
    dbms_output.put_line('');
    dbms_output.put_line('Actualizaci�n estado MO_EXECUTOR_LOG_MOT');
    dbms_output.put_line('=======================================================');
    dbms_output.put_line(sbcabecera);
    
    for rcdata in cudata(3) loop
        GE_BOINSTANCE.SETVALUE
        (
        MO_BOCONSTANTS.CSBMO_PACKAGES,
        MO_BOCONSTANTS.CSBPACKAGE_ID,
        rcdata.package_id,1
        );
        MO_BOATTENTION.ACTCREATEPLANWF;  
    End loop;
    
exception
    when others then
        sberror := sqlerrm;
        nuerror := sqlcode;
        
        dbms_output.put_line('=====================================================');
        dbms_output.put_line('Fin Reprocesamiento Solicitudes ['||nuerror||'-'||sberror||']');
  
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/