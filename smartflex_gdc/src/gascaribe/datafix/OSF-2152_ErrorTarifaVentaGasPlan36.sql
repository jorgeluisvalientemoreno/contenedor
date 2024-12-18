column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set linesize 1000
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;
/***********************************************************
ELABORADO POR:  Juan Gabriel Catuche Giron
EMPRESA:        MVM Ingenieria de Software
FECHA:          Enero 2024 
JIRA:           OSF-2152

Borra indexado de tarifa para la configuración de tartifa 547, plan 36, categoria 1 y subcategoria 2
la cual quedo desincronizada con respecto a la tarifa activa

    
    Archivo de entrada 
    ===================
    NA       
    
    Archivo de Salida 
    ===================
    NA
    
    --Modificaciones    
    04/01/2024 - jcatuchemvm
    Creación
    
***********************************************************/
declare
    cnuindice   constant TA_INDETABU.intainde%type := '547-|36|2|1';
    
    cursor cudata is
    select * from TA_INDETABU
    where intainde like '547-%';
    
    nucontador  number := 0;
    nuRowcount  number;
    sbgestion   varchar2(2000);
    nuerror     number;
    sberror     varchar2(2000);
    
begin
    dbms_output.put_line('Reg|Indice|Tarifa|Gestión');
    for rc in cudata loop
        nucontador := nucontador + 1;
        
        if rc.intainde = cnuindice then
            begin
                delete TA_INDETABU
                where intainde = cnuindice;
                
                nuRowcount := sql%rowcount;
                if nuRowcount > 0 then
                    commit;
                    sbgestion := 'Borrado';
                end if;
            exception
                when others then
                    rollback;
                    pkg_error.seterror;
                    pkg_error.geterror(nuerror,sberror);
                    sbgestion := 'Error en borrado: '||sberror;
                    
            end;
        else
            sbgestion := 'Consultado';
        end if;
        dbms_output.put_line(nucontador||'|'||rc.intainde||'|'||rc.intataco||'|'||sbgestion);
        
    end loop;
end;
/
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/

