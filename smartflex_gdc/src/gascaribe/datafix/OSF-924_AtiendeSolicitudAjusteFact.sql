column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;
/***********************************************************
ELABORADO POR:  Juan Gabriel Catuche Giron
EMPRESA:        MVM Ingenieria de Software
FECHA:          Febrero 2023
JIRA:           OSF-924

Atencion solicitudes de ajustes facturacion pendientes de aprobacion.
Solicitudes ya generaron la nota y los cargos, pero quedaron pendientes
Se atienden por BD, gestionando las tablas de aprobacion pendientes [fa_apromofa, fa_notaapro, fa_cargapro]

    
    Archivo de entrada 
    ===================
    NA            
    
    Archivo de Salida 
    ===================
    NA
    
    --Modificaciones    
    
    23/02/2023 - jcatuchemvm
    Creacion
    
***********************************************************/
declare
    --Constantes para el datafix
    csbFormato      constant varchar2(30) := 'dd/mm/yyyy hh24:mi:ss';
    cnuattentsol    constant mo_packages.motive_status_id%type := 14;
    cnuattentmot    constant mo_motive.motive_status_id%type := 11;    
    
    cursor cusol is
    select p.*,s.*,e.plan_id,(select status_id from wf_instance where instance_id = e.plan_id) wf_status,(select final_date from wf_instance where instance_id = e.plan_id) wf_final_date
    from mo_packages p,fa_apromofa s,wf_data_external e
    where p.package_id in (62628510,62629344,62628542,62626832,59301866)
    and apmosoli = p.package_id
    and e.package_id(+) = p.package_id
    ;
    
    cursor cumot (inupackage in mo_packages.package_id%type) is
    select * from mo_motive
    where package_id = inupackage;
    
    cursor cunota (inucons in fa_apromofa.apmocons%type) is
    select  n.*, (select max(cargfecr) from cargos where cargdoso = n.noapdoso) cargfecr from fa_notaapro n
    where noapapmo = inucons
    and exists 
    (
        select 'x' from notas
        where notanume = noapnume
        and notaapmo = noapapmo
    );
    
    rcnota  cunota%rowtype;
    
    cursor cuwf (inuplan in wf_instance.plan_id%type) is    
    select nvl(instance_1,-1) instance_1,nvl(instance_2,-1) instance_2,nvl(instance_3,-1) instance_3,
    nvl((select inst_tran_id from wf_instance_trans where origin_id = instance_1 and target_id = instance_2),-1) trans_1,
    nvl((select inst_tran_id from wf_instance_trans where origin_id = instance_2 and target_id = instance_3),-1) trans_2
    from 
    (
        select
        (select instance_id from wf_instance where plan_id = inuplan and unit_id = 728) instance_1,
        (select instance_id from wf_instance where plan_id = inuplan and unit_id = 731) instance_2,
        (select instance_id from wf_instance where plan_id = inuplan and unit_id = 724) instance_3
        from dual
    ) w;
    
    rcwf    cuwf%rowtype;
    
    nuRowcount  number;
    sbcabecera  varchar2(2000);
    s_out       varchar2(2000);
    sbBorraCrg  varchar2(1);
    sbBorraNta  varchar2(1);
    sbActuMot   varchar2(1);
    sbActuPkg   varchar2(1);
    sbActuWf    varchar2(1);
    nuCargos    number;
    nuNts       number;
    nuCrg       number;
    nuMtv       number;
    nuPkg       number;
    dtfecha     date;
    nuerror     ge_error_log.message_id%TYPE;
    sberror     ge_error_log.description%TYPE; 
    
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
    nuNts := 0;
    nuCrg := 0;
    nuMtv := 0;
    nuPkg := 0;
    
    dbms_output.put_line('OSF-924: Atencion solicitudes 289-Aprobacion de Ajustes de Facturacion');
    
    for rcdata in cusol loop
        
        --validacion notas a aprobar
        sbBorraCrg := 'N';
        sbBorraNta := 'N';
        sbActuMot := 'N';
        sbActuPkg := 'N';
        sbActuWf := 'N';
        nuCargos := 0;
        
        rcnota := null;
        open cunota(rcdata.apmocons);
        fetch cunota into rcnota;
        close cunota;
        
        if rcnota.noapnume is not null then
            --Borrado cargos pendientes. Ya existen los cargos
            delete fa_cargapro
            where caapnoap = rcnota.noapnume;
            
            nuRowcount := sql%rowcount;
            if nuRowcount > 0 then
                sbBorraCrg := 'S';
                nuCargos := nuRowcount;
                nuCrg := nuCrg + nuCargos;
            end if;
            
            --Borrado notas pendientes. Ya existe la nota
            delete fa_notaapro
            where noapapmo = rcdata.apmocons;
            
            nuRowcount := sql%rowcount;
            if nuRowcount > 0 then
                sbBorraNta := 'S';
                nuNts := nuNts + 1;
                
                sbcabecera := 'NOAPAPMO|NOAPNUME|NOAPSUSC|NOAPOBSE|NOAPTIDO|NOAPDOSO|NOAPFACT|FECHANOTA|SOLICITUD|CANT_CARGOSPENDIENTES|BORRADO_CARGOSP|BORRADO_NOTASP';
                dbms_output.put_line('_');
                dbms_output.put_line('Borrado notas y cargos pendientes FA_NOTAAPRO - FA_CARGAPRO');
                dbms_output.put_line('=======================================================');
                dbms_output.put_line(sbcabecera);
                s_out := rcnota.noapapmo;
                s_out := s_out||'|'||rcnota.noapnume;
                s_out := s_out||'|'||rcnota.noapsusc;
                s_out := s_out||'|'||rcnota.noapobse;
                s_out := s_out||'|'||rcnota.noaptido;
                s_out := s_out||'|'||rcnota.noapdoso;
                s_out := s_out||'|'||rcnota.noapfact;
                s_out := s_out||'|'||to_char(rcnota.cargfecr,csbFormato);
                s_out := s_out||'|'||rcdata.package_id;
                s_out := s_out||'|'||nuCargos;
                s_out := s_out||'|'||sbBorraCrg;
                s_out := s_out||'|'||sbBorraNta;
                dbms_output.put_line(s_out);
                
                sbcabecera := 'MOTIVO|STATUS_ANT|STATUS_ACT|ATTENTION_DATE_ANT|ATTENTION_DATE_ACT|STATUS_CHANGE_DATE_ANT|STATUS_CHANGE_DATE_ACT|ACTUALIZADO';
                dbms_output.put_line('_');
                dbms_output.put_line('Atencion Motivo de la solicitud MO_MOTIVE');
                dbms_output.put_line('=======================================================');
                dbms_output.put_line(sbcabecera);
                
                for rcmot in cumot(rcdata.package_id) loop
                    --atencion motivos
                    update mo_motive
                    set motive_status_id = cnuattentmot,
                    attention_date = rcnota.cargfecr,
                    status_change_date = rcnota.cargfecr
                    where motive_id = rcmot.motive_id;
                    
                    nuRowcount := sql%rowcount;
                    if nuRowcount > 0 then
                        nuMtv := nuMtv + nuRowcount;
                        sbActuMot := 'S';
                    end if;
                    
                    s_out := rcmot.motive_id;
                    s_out := s_out||'|'||rcmot.motive_status_id;
                    s_out := s_out||'|'||cnuattentmot;
                    s_out := s_out||'|'||rcmot.attention_date;
                    s_out := s_out||'|'||to_char(rcnota.cargfecr,csbFormato);
                    s_out := s_out||'|'||rcmot.status_change_date;
                    s_out := s_out||'|'||to_char(rcnota.cargfecr,csbFormato);
                    s_out := s_out||'|'||sbActuMot;
                    dbms_output.put_line(s_out);
                    
                end loop;
                
                --atencion aprobacion movimientos
                update fa_apromofa
                set apmoesaf = 'A',
                apmousar = apmousre,
                apmofear = rcnota.cargfecr
                where apmocons = rcdata.apmocons;
                
                --atencion solicitud
                update mo_packages
                set motive_status_id = cnuattentsol,
                attention_date = rcnota.cargfecr
                where package_id = rcdata.package_id;
                
                nuRowcount := sql%rowcount;
                if nuRowcount > 0 then
                    nuPkg := nuPkg + 1;
                    sbActuPkg := 'S';
                    
                    rcwf:=null;
                    open cuwf(rcdata.plan_id);
                    fetch cuwf into rcwf;
                    close cuwf;
                    
                    if rcwf.instance_1 is not null or rcwf.instance_1 != -1 then
                        update wf_instance
                        set status_id = 6,
                        final_date = rcnota.cargfecr 
                        where instance_id in (rcwf.instance_1,rcwf.instance_2,rcwf.instance_3)
                        and status_id != 6;
                        
                        update wf_instance_trans
                        set status = 2
                        where inst_tran_id in (rcwf.trans_1,rcwf.trans_2)
                        and status != 2;
                        
                    end if;
                    
                    update wf_instance
                    set status_id = 6,
                    final_date = rcnota.cargfecr 
                    where instance_id = rcdata.plan_id;
                    
                    nuRowcount := sql%rowcount;
                    if nuRowcount > 0 then
                        sbActuWf := 'S';
                    end if;
                    
                    commit;
                    
                end if;
                
                sbcabecera := 'SOLICITUD|PLAN_ID|APMOCONS|MOTIVE_STATUS_ANT|MOTIVE_STATUS_ACT|ATTENTION_DATE_ANT|ATTENTION_DATE_ACT|APMOESAF_ANT|APMOESAF_ACT|APMOUSAR_ANT|APMOUSAR_ACT|APMOFEAR_ANT|APMOFEAR_ACT|WF_STATUS_ANT|WF_STATUS_ACT|WF_FINAL_DATE_ANT|WF_FINAL_DATE_ACT|ACTU_SOL|ACTU_WF';
                dbms_output.put_line('_');
                dbms_output.put_line('Atencion Solicitud MO_PACKAGES - FA_APROMOFA - WF_INSTANCE');
                dbms_output.put_line('=======================================================');
                dbms_output.put_line(sbcabecera);
                s_out := rcdata.package_id;
                s_out := s_out||'|'||rcdata.plan_id;
                s_out := s_out||'|'||rcdata.apmocons;
                s_out := s_out||'|'||rcdata.motive_status_id;
                s_out := s_out||'|'||cnuattentsol;
                s_out := s_out||'|'||rcdata.attention_date;
                s_out := s_out||'|'||to_char(rcnota.cargfecr,csbFormato);
                s_out := s_out||'|'||rcdata.apmoesaf;
                s_out := s_out||'|'||'A';
                s_out := s_out||'|'||rcdata.apmousar;
                s_out := s_out||'|'||rcdata.apmousre;
                s_out := s_out||'|'||rcdata.apmofear;
                s_out := s_out||'|'||to_char(rcnota.cargfecr,csbFormato);
                s_out := s_out||'|'||rcdata.wf_status;
                s_out := s_out||'|'||6;
                s_out := s_out||'|'||rcdata.wf_final_date;
                s_out := s_out||'|'||to_char(rcnota.cargfecr,csbFormato);
                s_out := s_out||'|'||sbActuPkg;
                s_out := s_out||'|'||sbActuWf;
                dbms_output.put_line(s_out);
                
                dbms_output.put_line('_');
                dbms_output.put_line('----------------------------------------------------------------------------');
                dbms_output.put_line(' ');
                
                rollback;
                
            end if;
            
        else
            dbms_output.put_line('=====================================================');
            dbms_output.put_line('Sin registros de notas pendientes de aprobacion');
        end if; 
        
    end loop;
    
    dbms_output.put_line('_');
    dbms_output.put_line('=====================================================');
    dbms_output.put_line('Fin Atencion 289-Aprobacion de Ajustes de Facturacion');
    dbms_output.put_line('Cantidad Cargos Pendientse Borrados: '||nuCrg);
    dbms_output.put_line('Cantidad Notas Pendientes Borradas: '||nuNts);
    dbms_output.put_line('Cantidad Motivos Actualizados: '||nuMtv);
    dbms_output.put_line('Cantidad Solicitudes Actualizadas: '||nuPkg);
    dbms_output.put_line('Tiempo Total: '||fnc_rs_CalculaTiempo(dtfecha,sysdate));
exception
    when others then
        sberror := sqlerrm;
        nuerror := sqlcode;
        
        dbms_output.put_line('=====================================================');
        dbms_output.put_line('Fin Atencion 289-Aprobacion de Ajustes de Facturacion ['||nuerror||'-'||sberror||']');
        dbms_output.put_line('Cantidad Cargos Pendientse Borrados: '||nuCrg);
        dbms_output.put_line('Cantidad Notas Pendientes Borradas: '||nuNts);
        dbms_output.put_line('Cantidad Motivos Actualizados: '||nuMtv);
        dbms_output.put_line('Cantidad Solicitudes Actualizadas: '||nuPkg);
        dbms_output.put_line('Tiempo Total: '||fnc_rs_CalculaTiempo(dtfecha,sysdate));
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/