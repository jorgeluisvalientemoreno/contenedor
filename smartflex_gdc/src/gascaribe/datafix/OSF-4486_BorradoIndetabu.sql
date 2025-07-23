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
DEFINE CASO=OSF-4486

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
FECHA:          Mayo 2025
JIRA:           OSF-4486



    
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
    
    
    cursor cudata is
    select * from TA_INDETABU
    where intainde like '%41%';
    
    nucontador  number := 0;
    nuRowcount  number;
    sbgestion   varchar2(2000);
    nuerror     number;
    sberror     varchar2(2000);
    
begin
    dbms_output.put_line('Reg|Indice|Tarifa|Gestión');
    for rc in cudata loop
        nucontador := nucontador + 1;
    
        begin
            delete TA_INDETABU
            where intainde = rc.intainde;
            
            nuRowcount := sql%rowcount;
            if nuRowcount > 0 then
                commit;
                sbgestion := 'Borrado';
            else
                sbgestion := 'No Borrado';
            end if;
        exception
            when others then
                rollback;
                pkg_error.seterror;
                pkg_error.geterror(nuerror,sberror);
                sbgestion := 'Error en borrado: '||sberror;
                
        end;
        
        dbms_output.put_line(nucontador||'|'||rc.intainde||'|'||rc.intataco||'|'||sbgestion);
        
    end loop;
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

