column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;
/***********************************************************
ELABORADO POR:  Juan Gabriel Catuche Giron
EMPRESA:        MVM Ingenieria de Software
FECHA:          Noviembre 2023
JIRA:           OSF-1879

Ajusta movimientos de saldo a favor que no se aplicaron
    
    Archivo de entrada 
    ===================
    NA       
    
    Archivo de Salida 
    ===================
    OSF1879_AjustaMovisafaNoAplicadoMasivo_yyyymmdd_hh24mi.txt
    
    --Modificaciones    
    
    03/11/2023 - jcatuchemvm
    Creación
    
***********************************************************/
declare

    cdtfecha    constant date := sysdate;
    csbformato  constant varchar2(25) := 'dd/mm/yyyy hh24:mi:ss'; 
    csbCaso     constant varchar2(10) := 'OSF-1879';
    csbTitulo   constant varchar2(200) := csbCaso||' Actualiza actividades inconsistentes de flujos anulados';
    csbArchivo  constant varchar2(200) := replace(csbCaso,'-','')||'_ActualizaActividadesFlujo_'||to_char(cdtfecha,'yyyymmdd_hh24mi')||'.txt';
        
    cursor cudata is
    with sol as
    (
        select /*+ index ( p IDX_MO_PACKAGES_024 ) use_nl ( p m i )
        index ( i IDX_MO_WF_PACK_INTERFAC_01 ) */ 
        p.package_id,p.package_type_id,p.motive_status_id motive_status_pack,
        m.motive_id,m.motive_status_id motive_status_mot,m.product_id,m.annul_causal_id,m.subscription_id,
        p.request_date,p.ATTENTION_DATE,m.annul_date,
        (
            SELECT b.init_pay_expiration
            FROM cc_financing_request b
            WHERE b.financing_request_id = p.package_id
        ) init_pay_expiration
        from mo_packages p,mo_motive m --,mo_wf_pack_interfac i
        where p.package_type_id = 279
        and p.motive_status_id = 32
        and m.package_id = p.package_id
    )
    select 
    s.package_id,s.package_type_id,s.motive_status_pack,
    s.motive_id,s.motive_status_mot,s.product_id,s.annul_causal_id,s.subscription_id,
    i.wf_pack_interfac_id,i.activity_id,
    i.status_activity_id,i.try_amount,
    s.request_date,s.ATTENTION_DATE,s.annul_date,
    s.init_pay_expiration,i.recording_date,i.attendance_date,(select status_id from wf_instance where instance_id = i.activity_id) status_id,
    (select final_date from wf_instance where instance_id = i.activity_id) final_date,
    causal_id_output,
    executor_log_id
    from sol s,mo_wf_pack_interfac i
    where i.package_id = s.package_id
    and i.action_id = 268
    and i.status_activity_id = 4
    ;
    
    cursor cuvalida is
    select 
    null
    from dual;
    
    rcvalida    cuvalida%rowtype;

    
    nucontador   number;
    nucontador2  number;
    sbActualiza  varchar2(200);
    
    nuok         number;
    nuerr        number;
    nuajuste     number;
    
    flout        utl_file.file_type;
    sbRuta       parametr.pamechar%type;
    sblinea      varchar2(2000);
    nuRowCount   number;
    
    s_out       varchar2(2000);
    s_out2      varchar2(2000);
    
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
    
    procedure procescribe(isbmensaje in varchar)
    is
    begin
        dbms_output.put_line(isbmensaje);
        Utl_file.put_line(flout,isbmensaje,TRUE);
    exception
        when others then
            dbms_output.put_line('Error en escritura de linea. '||sqlerrm);
    end procescribe;
    

    
begin
    nuok := 0;
    nuerr := 0;
    nuajuste := 0;
    
    sbRuta := '/smartfiles/tmp'; 
    flout := utl_file.fopen(sbRuta,csbArchivo,'w');
    
    
    dbms_output.enable;
    dbms_output.enable (buffer_size => null);
    
    procescribe(csbTitulo);
    sblinea := 'Package_Id|Package_Type_Id|Motive_Status_Pack|Product_Id|Subscription_Id|Wf_Pack_Interfac_Id|Activity_Id|Try_Amount|Request_Date|Annul_Date|Init_Pay_Expiration|Recorgding_Date|';
    Sblinea := Sblinea||'Status_Id_Ant|Status_Id_Act|Final_Date_Ant|Final_Date_Act|Causal_Id_Output_Ant|Causal_Id_Output_Act|Executor_Log_Id_Ant|Executor_Log_Id_Act|Status_Activity_Ant|Status_Activity_Act|';
    Sblinea := Sblinea||'Attendance_Date_Ant|Attendance_Date_Act|Actualiza';
    procescribe(sblinea);
    
    for rc in cudata loop
       
        rcvalida := null;
        open cuvalida;
        fetch cuvalida into rcvalida;
        close cuvalida;
        
        update wf_instance
        set status_id = 14, final_date = rc.annul_date
        where instance_id = rc.activity_id
        and action_id = 268;
        
        nuRowcount := sql%rowcount;
        if nuRowcount > 0 then            
            sbactualiza := 'S';
        else 
            sbactualiza := 'No se pudo actualizar el estado de la instancia';
            nuerr := nuerr + 1;
        end if;
        
        if sbactualiza = 'S' then
                
            update mo_wf_pack_interfac
            set status_activity_id = 3, causal_id_output = 1, executor_log_id = null, attendance_date = rc.annul_date
            where wf_pack_interfac_id = rc.wf_pack_interfac_id 
            and activity_id = rc.activity_id
            and package_id = rc.package_id
            and action_id = 268;
            
            nuRowcount := sql%rowcount;
            if nuRowcount > 0 then            
                sbactualiza := 'S';
                nuok := nuok + 1;
                commit;
            else 
                nuerr := nuerr + 1;
                sbactualiza := 'No se pudo actualizar el estado del registro de actividades WF';
            end if;
        
        end if;
            
        s_out := rc.package_id;
        s_out := s_out||'|'||rc.package_type_id;
        s_out := s_out||'|'||rc.motive_status_pack;
        s_out := s_out||'|'||rc.product_id;
        s_out := s_out||'|'||rc.subscription_id;
        s_out := s_out||'|'||rc.wf_pack_interfac_id;
        s_out := s_out||'|'||rc.activity_id;
        s_out := s_out||'|'||rc.try_amount;
        s_out := s_out||'|'||to_date(rc.request_date,csbFormato);
        s_out := s_out||'|'||to_date(rc.annul_date,csbFormato);
        s_out := s_out||'|'||to_date(rc.init_pay_expiration,csbFormato);
        s_out := s_out||'|'||to_date(rc.recording_date,csbFormato);
        s_out := s_out||'|'||rc.status_id;
        s_out := s_out||'|'||case when sbactualiza = 'S' then 14 else rc.status_id end;
        s_out := s_out||'|'||to_date(rc.final_date,csbFormato);
        s_out := s_out||'|'||case when sbactualiza = 'S' then to_date(rc.annul_date,csbFormato) else to_date(rc.final_date,csbFormato) end;
        s_out := s_out||'|'||rc.causal_id_output;
        s_out := s_out||'|'||case when sbactualiza = 'S' then 1 else rc.causal_id_output end;
        s_out := s_out||'|'||rc.executor_log_id;
        s_out := s_out||'|'||case when sbactualiza = 'S' then null else rc.executor_log_id end;
        s_out := s_out||'|'||rc.status_activity_id;
        s_out := s_out||'|'||case when sbactualiza = 'S' then 3 else rc.status_activity_id end;
        s_out := s_out||'|'||to_date(rc.attendance_date,csbFormato);
        s_out := s_out||'|'||case when sbactualiza = 'S' then to_date(rc.annul_date,csbFormato) else to_date(rc.attendance_date,csbFormato) end;
        
        procescribe(s_out||'|'||sbactualiza);
    

    
    end loop;
    
    procescribe('===================================');
    procescribe('Total de Actividades actualizadas '||nuok);
    procescribe('Total de Errores '||nuerr);
    procescribe('Rango Total de Ejecución ['||to_char(cdtFecha,'dd/mm/yyyy')||']['||to_char(cdtFecha,'hh24:mi:ss')||' - '||to_char(sysdate,'hh24:mi:ss')||']');
    procescribe('Tiempo Total de Ejecución ['||fnc_rs_CalculaTiempo(cdtFecha,sysdate)||']');
    
    if utl_file.is_open( flout ) then
        utl_file.fclose( flout );
    end if;
end;
/
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/