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
DEFINE CASO=OSF-2470

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
FECHA:          Marzo 2024 
JIRA:           OSF-2470

Elimina planes especiales viejos y requeridos en la solicitud
LDC_SPECIALS_PLAN

    
    Archivo de entrada 
    ===================
    NA       
    
    Archivo de Salida 
    ===================
    NA
    
    --Modificaciones    
    08/03/2024 - jcatuchemvm
    Creación
    
***********************************************************/
DECLARE
    csbFormato          CONSTANT VARCHAR2(25) := 'DD/MM/YYYY HH24:MI:SS';
    
    cursor cudata is
    SELECT rowid row_id,specials_plan_id,plan_id,product_id,init_date,end_Date, 'P' tipo
    from LDC_SPECIALS_PLAN
    where plan_id in (186,187,188) 
    and end_date >= sysdate
    union all
    select rowid row_id,specials_plan_id,plan_id,product_id,init_date,end_Date, 'M' tipo 
    from LDC_SPECIALS_PLAN
    where end_date < add_months(sysdate,-6)
    ;
    
    
    nucontador          number;
    nuplanes            number;
    nuhisto6            number;
    s_out               varchar2(2000);
    nuerr               number;
    sberror             varchar2(2000);
    nuerror             number;
    nurowcount          number;
    
BEGIN
    nucontador := 0;
    nuplanes   := 0;
    nuhisto6   := 0;
    nuerr      := 0;
    dbms_output.put_line('Borrado de planes especiales OSF-2470');
    dbms_output.put_line('================================================');
    dbms_output.put_line('SPECIAL_PLAN_ID|PLAN_ID|PRODCUT_ID|INITIAL_DATE|END_DATE|TIPO|ERROR');
    
    for rcdata in cudata loop
        begin 
            delete LDC_SPECIALS_PLAN
            where rowid = rcdata.row_id;
            
            nuRowcount := sql%rowcount;
            if nuRowcount = 1 then 
                if rcdata.tipo = 'P' then
                    nuplanes := nuplanes + 1;
                else  
                    nuhisto6 := nuhisto6 + 1;
                end if;
                commit;
            else
                s_out := rcdata.specials_plan_id;
                s_out := s_out||'|'||rcdata.plan_id;
                s_out := s_out||'|'||rcdata.product_id;
                s_out := s_out||'|'||to_char(rcdata.init_date,csbFormato);
                s_out := s_out||'|'||to_char(rcdata.end_date,csbFormato);
                s_out := s_out||'|'||case when rcdata.tipo = 'P' then 'Planes vigentes' else 'Historicos 6 Meses' end;
                s_out := s_out||'|Error en borrado, registros borrados diferentes a 1 ['||nuRowcount||']';
                dbms_output.put_line(s_out);
                rollback;
                nuerr := nuerr + 1;
            end if;
          
        exception
            when others then
                nuerr := nuerr + 1;
                pkg_error.geterror(nuerror,sberror);
                s_out := rcdata.specials_plan_id;
                s_out := s_out||'|'||rcdata.plan_id;
                s_out := s_out||'|'||rcdata.product_id;
                s_out := s_out||'|'||to_char(rcdata.init_date,csbFormato);
                s_out := s_out||'|'||to_char(rcdata.end_date,csbFormato);
                s_out := s_out||'|'||case when rcdata.tipo = 'P' then 'Planes vigentes' else 'Historicos 6 Meses' end;
                s_out := s_out||'|Error desconocido en borrado. '||sberror;
                dbms_output.put_line(s_out);
        end;
    end loop;
    
    dbms_output.put_line('================================================');
    dbms_output.put_line('Fin borrado tabla LDC_SPECIALS_PLAN');
    dbms_output.put_line('Cantidad de registros historicos borrados mayores a 6 meses: '||nuhisto6);
    dbms_output.put_line('Cantidad de registros de planes 186,187 y 188 activos borrados: '||nuplanes);
    dbms_output.put_line('Cantidad de errores: '||nuerr);
    
END;
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
