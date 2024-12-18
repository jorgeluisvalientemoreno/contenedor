column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;
/***********************************************************
ELABORADO POR:  Juan Gabriel Catuche Girón
EMPRESA:        MVM Ingeniería de Software
FECHA:          Diciembre 2022
JIRA:           OSF-774

Reprocesmiento de solicitudes 100232 - Visita de Venta de Gas que no crearon flujo

    
    Archivo de entrada 
    ===================
    NA            
    
    Archivo de Salida 
    ===================
    NA
    
    --Modificaciones    
    
    27/12/2022 - jcatuchemvm
    Creación
    
***********************************************************/
declare
    --Constantes para el datafix
    csbFormato      constant varchar2(30) := 'dd/mm/yyyy hh24:mi:ss';
    
    --Cursor para extracción de data
    cursor cudata(inustatus in MO_EXECUTOR_LOG_MOT.STATUS_EXEC_LOG_ID%TYPE default 1) is 
    select e.executor_log_mot_id,e.package_id,e.LOG_DATE,e.status_exec_log_id, 4 status_exec_log_id_act
    from MO_EXECUTOR_LOG_MOT e
    where package_id in (
    192763848,
    192763970,
    192763780,
    192762765,
    192766670,
    192762467,
    192762600,
    192765750,
    192765905,
    192766209,
    192765014,
    192764736,
    192765252,
    192749617,
    192767013,
    192762455,
    192762594,
    192765804,
    192766018,
    192766085,
    192766283
    )
    and e.status_exec_log_id = inustatus
    and not exists
    (
        select 'x' from wf_data_external w, wf_instance i
        where w.package_id = e.package_id
        and w.plan_id = i.plan_id
        and i.unit_type_id = 100545
        
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
    
    FUNCTION fnc_rs_CalculaTiempo
    (
        idtFechaIni IN DATE,
        idtFechaFin IN DATE
    )
    RETURN VARCHAR2
    IS
        nuTiempo NUMBER;
        nuHoras NUMBER;
        nuMinutos NUMBER;
        sbRetorno VARCHAR2( 100 );
    BEGIN
        -- Convierte los dias en segundos
        nuTiempo := ( idtFechaFin - idtFechaIni ) * 86400;
        -- Obtiene las horas
        nuHoras := TRUNC( nuTiempo / 3600 );
        -- Publica las horas
        sbRetorno := TO_CHAR( nuHoras ) ||'h ';
        -- Resta las horas para obtener los minutos
        nuTiempo := nuTiempo - ( nuHoras * 3600 );
        -- Obtiene los minutos
        nuMinutos := TRUNC( nuTiempo / 60 );
        -- Publica los minutos
        sbRetorno := sbRetorno ||TO_CHAR( nuMinutos ) ||'m ';
        -- Resta los minutos y obtiene los segundos redondeados a dos decimales
        nuTiempo := TRUNC( nuTiempo - ( nuMinutos * 60 ), 2 );
        -- Publica los segundos
        sbRetorno := sbRetorno ||TO_CHAR( nuTiempo ) ||'s';
        -- Retorna el tiempo
        RETURN( sbRetorno );
    EXCEPTION
        WHEN OTHERS THEN
            -- No se eleva excepcion, pues no es parte fundamental del proceso
            RETURN NULL;
    END fnc_rs_CalculaTiempo;
    
begin
    dtfecha := sysdate;
    nuok := 0;
    nuerr := 0;
    nuoks := 0;
    nuerrs := 0;
    
    sbcabecera := 'Executor_Log_Mot_Id|Package_Id|Log_Date|Status_Exec_Log_Id_Ant|Status_Exec_Log_Id_Act|Actualizado';
    dbms_output.put_line('OSF-774: Reprocesar Solicitudes Visita Gas');
    dbms_output.put_line('');
    dbms_output.put_line('Actualización estado MO_EXECUTOR_LOG_MOT');
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
    
        begin
            sbActualiza := 'N';
            
            MO_BOEXECUTOR_LOG_MOT.MANUALSEND
            (
                rcdata.Executor_Log_Mot_Id,null,
                nuerror,sberror
            );
                
            if nuerror = 0 then
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
    dbms_output.put_line('Fin Reprocesamiento Solicitudes Visita Gas');
    dbms_output.put_line('Cantidad Registros Actualizados: '||nuok);
    dbms_output.put_line('Cantidad Registros con Error: '||nuerr);
    dbms_output.put_line('Cantidad Solicitudes Reprocesadas: '||nuoks);
    dbms_output.put_line('Cantidad Solicitudes con Error Reprocesamiento: '||nuerrs);
    dbms_output.put_line('Tiempo Total: '||fnc_rs_CalculaTiempo(dtfecha,sysdate));
    
exception
    when others then
        sberror := sqlerrm;
        nuerror := sqlcode;
        
        dbms_output.put_line('=====================================================');
        dbms_output.put_line('Fin Reprocesamiento Solicitudes Visita Gas ['||nuerror||'-'||sberror||']');
        dbms_output.put_line('Cantidad Registros Borrados: '||nuok);
        dbms_output.put_line('Cantidad Registros con Error: '||nuerr);
        dbms_output.put_line('Cantidad Solicitudes Reprocesadas: '||nuoks);
        dbms_output.put_line('Cantidad Solicitudes con Error Reprocesamiento: '||nuerrs);
        dbms_output.put_line('Tiempo Total: '||fnc_rs_CalculaTiempo(dtfecha,sysdate));
  
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/