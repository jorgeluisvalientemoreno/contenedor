set serveroutput on size unlimited
set linesize 1000
set timing on
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

COLUMN instancia new_val instancia format a20;
COLUMN fecha_ejec new_val fecha_ejec format a20;
COLUMN esquema new_val esquema format a20;
COLUMN ejecutado_por new_val ejecutado_por format a20;
COLUMN usuario_so new_val usuario_so format a35;
COLUMN fecha_fin new_val fecha_fin format a25
DEFINE CASO=OSF-2339

SELECT SYS_CONTEXT('USERENV', 'DB_NAME') instancia,
   TO_CHAR(SYSDATE, 'yyyymmdd_hh24miss') fecha_ejec,
   SYS_CONTEXT('USERENV','CURRENT_SCHEMA') esquema,
   USER ejecutado_por,
   SYS_CONTEXT('USERENV', 'OS_USER') usuario_so
FROM DUAL;

PROMPT
PROMPT =========================================
PROMPT  ****   Información de Ejecución    ****
PROMPT =========================================
PROMPT Instancia        : &instancia
PROMPT Fecha ejecución  : &fecha_ejec
PROMPT Usuario DB       : &ejecutado_por
PROMPT Usuario O.S      : &usuario_so
PROMPT Esquema          : &esquema
PROMPT CASO             : &CASO
PROMPT =========================================
PROMPT

-- This is a new line in master / 2

prompt "------------------------------------------------------"
prompt "Aplicando Entrega"
prompt "------------------------------------------------------"
/***********************************************************
ELABORADO POR:  Juan Gabriel Catuche Giron
EMPRESA:        MVM Ingenieria de Software
FECHA:          Febrero 2024
JIRA:           OSF-2339

Gestiona solicitudes de reconexión por pago sin flujo creado, reenvia flujo y anula solicitudes

    
    Archivo de entrada 
    ===================
    NA       
    
    Archivo de Salida 
    ===================
    NA
    
    --Modificaciones    
    21/02/2024 - jcatuchemvm
    Creación
    
***********************************************************/
declare
    cursor cusol is 
    select /*+ index ( p IDX_MO_PACKAGES_024 ) */ unique p.package_id,
    (select package_type_id||'-'||description from ps_package_type pt where pt.package_type_id = p.package_type_id) package_type_id,
    p.request_date,
    (
        select paa.package_id 
        from mo_packages_asso pa,mo_packages paa 
        where pa.package_id = p.package_id
        and paa.package_id = pa.package_id_asso 
        and paa.package_type_id != 268
        and paa.package_type_id = 328
    ) package_id_asso,
    (
        select pt.package_type_id||'-'||pt.description
        from mo_packages_asso pa,mo_packages paa,ps_package_type pt
        where pa.package_id = p.package_id
        and paa.package_id = pa.package_id_asso 
        and paa.package_type_id != 268
        and paa.package_type_id = 328
        and pt.package_type_id = paa.package_type_id
    ) package_type_id_asso,
    (
        select paa.motive_status_id||'-'||description 
        from mo_packages_asso pa,mo_packages paa,ps_motive_status s
        where pa.package_id = p.package_id
        and paa.package_id = pa.package_id_asso 
        and paa.package_type_id != 268
        and paa.package_type_id = 328
        and s.motive_status_id = paa.motive_status_id
    ) motive_status_id_asso,
    (
        select paa.attention_date 
        from mo_packages_asso pa,mo_packages paa 
        where pa.package_id = p.package_id
        and paa.package_id = pa.package_id_asso 
        and paa.package_type_id != 268
        and paa.package_type_id = 328
    ) attention_date_asso,
    (
        select ma.annul_date
        from mo_packages_asso pa,mo_packages paa,mo_motive ma
        where pa.package_id = p.package_id
        and paa.package_id = pa.package_id_asso 
        and paa.package_type_id != 268
        and paa.package_type_id = 328
        and ma.package_id = paa.package_id
    ) annul_date_asso,
    m.product_id,p.motive_status_id,
    (select sesuesco from servsusc where sesunuse = m.product_id) sesuesco,
    (
        select unique first_value(hcececac||'-'||escodesc) over (order by hcecfech desc) from hicaesco,estacort where hcecnuse = m.product_id and escocodi = hcececac
    ) hcececac,
    (
        select unique first_value(hcececan||'-'||escodesc) over (order by hcecfech desc) from hicaesco,estacort where hcecnuse = m.product_id and escocodi = hcececan
    ) hcececan,
    (
        select unique first_value(hcecfech) over (order by hcecfech desc) from hicaesco where hcecnuse = m.product_id
    ) hcecfech,
    (
        select a.order_id
        from or_order_activity a 
        where a.product_id = m.product_id
        and a.status = 'R'
        and exists
        (
            select 'x' from suspcone
            where suconuor = a.order_id
        )
    ) order_id,
    (
        select t.task_type_id||'-'||t.description
        from or_order_activity a,or_task_type t
        where a.product_id = m.product_id
        and a.status = 'R'
        and a.task_type_id = t.task_type_id
        and exists
        (
            select 'x' from suspcone
            where suconuor = a.order_id
        )
    ) task_type,
    (
        select sucofeor
        from or_order_activity a,suspcone
        where a.product_id = m.product_id
        and a.status = 'R'
        and suconuor = a.order_id
    ) sucofeor,
    (
        select sucotipo
        from or_order_activity a,suspcone
        where a.product_id = m.product_id
        and a.status = 'R'
        and suconuor = a.order_id
    ) sucotipo
    from mo_packages p,mo_motive m 
    where p.package_type_id = 300 
    and p.motive_status_id = 13
    and m.package_id = p.package_id
    and not exists
    (
        select 'x' 
        from wf_data_external d
        where d.package_id = p.package_id
    )
    order by p.package_id
    ;
    
    nuok    number;
    nuerr   number;
    nurfl   number;
    nuerror number;
    sberror varchar2(2000);
    
    nucontador      number;
    sbactualiza     varchar2(200);
    s_out           varchar2(4000);
    
begin
    nuok := 0;
    nuerr := 0;
    nurfl := 0;
    nucontador := 0;
    dbms_output.put_line('Gestión de solicitudes de reconexión por pago sin flujo creado - OSF-2339');
    dbms_output.put_line('Solicitud|Tipo|Fecha|SolAsso|TipoAsso|Producto|Estado|Orden|Actualizado');
    for rs in cusol loop
        nucontador := nucontador+1;
        begin
            if rs.motive_status_id_asso is not null and rs.motive_status_id_asso not in ('32-Anulado','14-Atendido') then
                sbactualiza := 'Solicitud Asociada no gestionada';
                nuerr := nuerr + 1; 
            elsif rs.sesuesco = 6 and rs.order_id is null then
                --Reenvio de solicitud para crear flujo
                GE_BOINSTANCE.SETVALUE
                (
                    MO_BOCONSTANTS.CSBMO_PACKAGES,
                    MO_BOCONSTANTS.CSBPACKAGE_ID,
                    rs.package_id,1
                );
                MO_BOATTENTION.ACTCREATEPLANWF;
                sbactualiza := 'Flujo reenviado';
                nurfl := nurfl + 1;
                
            elsif rs.sesuesco in (1,3) or (rs.sesuesco = 2 and rs.order_id is not null) then
                --Anulación Solicitud
                MO_BOANNULMENT.PACKAGEINTTRANSITION(rs.package_id,GE_BOPARAMETER.FNUGET('ANNUL_CAUSAL', 'Y'));
                nuok := nuok + 1;
                sbactualiza := 'Solicitud Anulada';
            else
                --Escenario no considerado
                sbactualiza := 'Escenario no considerado';
                nuerr := nuerr + 1;
            end if; 
            
            commit;
            
        exception
            when others then
                pkg_error.seterror;
                pkg_error.geterror(nuerror,sberror);
                sbactualiza := 'Error en gestión '||sberror;
                nuerr := nuerr + 1;
                rollback;            
        end;
        
        s_out := rs.package_id;
        s_out := s_out||'|'||rs.package_type_id;
        s_out := s_out||'|'||to_char(rs.request_date,'dd/mm/yyyy hh24:mi:ss');
        s_out := s_out||'|'||rs.package_id_asso;
        s_out := s_out||'|'||rs.package_type_id_asso;
        s_out := s_out||'|'||rs.product_id;
        s_out := s_out||'|'||rs.sesuesco;
        s_out := s_out||'|'||rs.order_id;
        s_out := s_out||'|'||sbactualiza;
        
        dbms_output.put_line(s_out);
        
    end loop;
    
    if nucontador = 0 then
        dbms_output.put_line('Sin solicitudes para gestión');
        nuerr := nuerr + 1;
    end if;
    
    dbms_output.put_line('===========================================');
    dbms_output.put_line('Cantidad de solicitudes reenviadas: '||nurfl);
    dbms_output.put_line('Cantidad de solicitudes anuladas: '||nuok);
    dbms_output.put_line('Cantidad de errores encontrados: '||nuerr);
    
end;
/
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;

PROMPT **** FIN EJECUCIÓN ****
PROMPT CASO             : &CASO
PROMPT Fecha fin        : &fecha_fin
PROMPT =========================================

set timing off
set serveroutput off
quit
/
