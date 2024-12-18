column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

/***********************************************************
ELABORADO POR:  Juan Gabriel Catuche Giron
EMPRESA:        MVM Ingenieria de Software
FECHA:          Septiembre 2023
JIRA:           OSF-1449

Actualiza saldo a favor producto desincronizado

    
    Archivo de entrada 
    ===================
    NA
    Archivo de Salida 
    ===================
    NA
    
    --Modificaciones    
    13/09/2023 - jcatuchemvm  
    Creación
        
***********************************************************/
declare
    cdtfecha        constant varchar2(25) := 'dd/mm/yyyy hh24:mi:ss';
    csbcaso         constant varchar2(10) := 'OSF-1449';
    
    cursor cudata is
    select p.package_id,p.package_type_id,p.request_Date,p.motive_status_id,p.attention_date,p.subscriber_id,
    m.motive_id,m.motive_status_id motive_status_id_mot,m.attention_date attention_date_motivo,m.subscription_id,
    a.package_id_asso,a.annul_dependent,
    pa.request_Date request_data_asso,pa.motive_status_id motive_status_id_asso,pa.attention_date attention_date_asso
    from mo_packages p,mo_motive m,mo_packages_asso a,mo_packages pa
    where p.package_id in (201358453,198904902)
    and p.package_id = m.package_id(+)
    and p.package_id = a.package_id(+)
    and a.package_id_asso =  pa.package_id(+)
    and p.package_type_id = 100342
    ;
    
    type tytbdata is table of cudata%rowtype index by binary_integer;
    tbdata tytbdata;
    
    cursor cudata2(inupaq number) is
    select p.package_id,p.package_type_id,p.request_Date,p.motive_status_id,p.attention_date,p.subscriber_id,
    m.motive_id,m.motive_status_id motive_status_id_mot,m.attention_date attention_date_motivo,m.subscription_id,
    a.package_id_asso,a.annul_dependent,
    pa.request_Date request_data_asso,pa.motive_status_id motive_status_id_asso,pa.attention_date attention_date_asso
    from mo_packages p,mo_motive m,mo_packages_asso a,mo_packages pa
    where p.package_id = inupaq
    and p.package_id = m.package_id(+)
    and p.package_id = a.package_id(+)
    and a.package_id_asso =  pa.package_id(+)
    and p.package_type_id = 100342;
    
    rcact       cudata2%rowtype;
    sbactualiza varchar2(2000);
    s_out       varchar2(2000);
begin
    dbms_output.put_line(csbcaso||' Atención Solicitudes');
    dbms_output.put_line('Solicitud|Tipo|FechaSol|Cliente|Contrato|Motivo|SolicitudAsso|EstadoSol_ant|EstadoSol_act|EstadoMot_ant|EstadoMot_act|EstadoSolAsso_ant|EstadoSolAsso_act|FechaAtencion|Actualizado');
    
    tbdata.delete;
    
    open cudata;
    fetch cudata bulk collect into tbdata;
    close cudata;
    
    if tbdata.count = 0 then
        dbms_output.put_line('Sin datos de solicitudes para atender');
    else
        for i in tbdata.first .. tbdata.last loop
            if tbdata(i).motive_status_id = 13 then
            
                begin
                    sbactualiza := '';
                    CF_BOACTIONS.ATTENDREQUEST(tbdata(i).package_id);
                    
                    IF tbdata(i).package_id_asso is not null and tbdata(i).motive_status_id_asso =  13 then
                        CF_BOACTIONS.ATTENDREQUEST(tbdata(i).package_id_asso);
                    end if;
                    
                    commit;
                    
                exception
                    when others then
                        sbactualiza := ': '||sqlcode||'-'||sqlerrm;
                        rollback;
                end;
                 
                open cudata2(tbdata(i).package_id);
                fetch cudata2 into rcact;
                close cudata2;

                if rcact.motive_status_id = tbdata(i).motive_status_id  then
                    sbactualiza := 'N'||sbactualiza;
                else
                    sbactualiza := 'S'||sbactualiza;
                end if;
                
            else
                rcact.motive_status_id      := tbdata(i).motive_status_id;
                rcact.motive_status_id_mot  := tbdata(i).motive_status_id_mot;
                rcact.motive_status_id_asso := tbdata(i).motive_status_id_asso;
                rcact.attention_date        := tbdata(i).attention_date;
                sbactualiza := 'N Solicitud en estado diferente a pendiente';
            end if;
            
            s_out := tbdata(i).package_id;
            s_out := s_out||'|'||tbdata(i).package_type_id;
            s_out := s_out||'|'||to_char(tbdata(i).request_date,cdtfecha);
            s_out := s_out||'|'||tbdata(i).subscriber_id;
            s_out := s_out||'|'||tbdata(i).subscription_id;
            s_out := s_out||'|'||tbdata(i).motive_id;
            s_out := s_out||'|'||tbdata(i).package_id_asso;
            s_out := s_out||'|'||tbdata(i).motive_status_id;
            s_out := s_out||'|'||rcact.motive_status_id;
            s_out := s_out||'|'||tbdata(i).motive_status_id_mot;
            s_out := s_out||'|'||rcact.motive_status_id_mot;
            s_out := s_out||'|'||tbdata(i).motive_status_id_asso;
            s_out := s_out||'|'||rcact.motive_status_id_asso;
            s_out := s_out||'|'||to_char(rcact.attention_date,cdtfecha);
            s_out := s_out||'|'||sbactualiza;
            
            dbms_output.put_line
            (
                s_out
            );
        
        end loop;
    end if;
     
end;
/
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/