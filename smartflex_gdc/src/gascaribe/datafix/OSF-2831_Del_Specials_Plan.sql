set serveroutput on size unlimited
set linesize 1000
set timing on
execute dbms_application_info.set_action('APLICANDO DATAFIX OSF-2831');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

COLUMN instancia new_val instancia format a20;
COLUMN fecha_ejec new_val fecha_ejec format a20;
COLUMN esquema new_val esquema format a20;
COLUMN ejecutado_por new_val ejecutado_por format a20;
COLUMN usuario_so new_val usuario_so format a35;
COLUMN fecha_fin new_val fecha_fin format a25;
DEFINE CASO=OSF-2831

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
/*
OSF-2831 Eliminar registros de la forma LDGPE
         Se requiere eliminar los registros de la forma LDGPE 
         del plan 143 y 145 del 1 al 30 de junio de 2024

14/06/2024 - GDGuevara - Elimina registros de la tabla LDC_SPECIALS_PLAN
*/
DECLARE
    csbFmFecha      CONSTANT VARCHAR2(25) := 'DD/MM/YYYY HH24:MI:SS';
    
    CURSOR cuData is
        SELECT rowid ROW_ID, p.*
        FROM open.ldc_specials_plan p
        WHERE p.plan_id in (143 , 145) 
          AND trunc(p.init_date) between to_date('01/06/2024','dd/mm/yyyy')
                                     and to_date('30/06/2024','dd/mm/yyyy');

    nuOK            NUMBER;
    nuERR           NUMBER;
    nuTotal         NUMBER;
    sbMsg           VARCHAR2(2000);
    sbError         VARCHAR2(2000);
    nuError         NUMBER;
    nuCont          NUMBER;
    
BEGIN
    nuOK    := 0;
    nuERR   := 0;
    nuTotal := 0;
    dbms_output.put_line('Borrado de planes especiales OSF-2831');
    dbms_output.put_line('=============================================================================='||chr(10));
    dbms_output.put_line('SPECIALS_PLAN_ID|SUBSCRIPTION_ID|PRODUCT_ID|PLAN_ID|INIT_DATE|END_DATE|MENSAJE');
    
    FOR rc IN cuData LOOP
        nuTotal := nuTotal + 1;
        BEGIN 
            sbMsg := null;
            nuCont := null;
            -- elimina cada registro
            DELETE LDC_SPECIALS_PLAN
            WHERE rowid = rc.ROW_ID
            RETURNING count(1) into nuCont;

            sbMsg := rc.specials_plan_id ||'|'|| rc.subscription_id ||'|'|| rc.product_id ||'|'|| rc.plan_id||'|'||
                     to_char(rc.init_date, csbFmFecha) ||'|'|| to_char(rc.end_date, csbFmFecha);

            -- Valida si el registro fue borrado
            if nvl(nuCont,0) > 0 then 
                nuOK := nuOK + 1;
                sbMsg := sbMsg||'|Borrado OK';
            else
                nuERR := nuERR + 1;
                sbMsg := sbMsg||'|Error al borrar';
            end if;
            dbms_output.put_line(sbMsg);            
          
        EXCEPTION
            WHEN OTHERS THEN
                nuERR := nuERR + 1;
                pkg_error.geterror(nuError,sbError);
                sbMsg := rc.specials_plan_id ||'|'|| rc.subscription_id ||'|'|| rc.product_id ||'|'|| rc.plan_id||'|'||
                         to_char(rc.init_date, csbFmFecha) ||'|'|| to_char(rc.end_date, csbFmFecha);
                sbMsg := sbMsg||'|Error desconocido en borrado. '||sbError;
                dbms_output.put_line(sbMsg);
        END;
    END LOOP;
    
    -- Asienta todas las transacciones
    COMMIT;
    
    dbms_output.put_line(chr(10)||'=============================================================================='||chr(10));
    dbms_output.put_line('Fin borrado tabla LDC_SPECIALS_PLAN');
    dbms_output.put_line('Total registros seleccionados: '||nuTotal);
    dbms_output.put_line('Total registros borrados: '||nuOK);
    dbms_output.put_line('Total de errores: '||nuERR);
    
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
