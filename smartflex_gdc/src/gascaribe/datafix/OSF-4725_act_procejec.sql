SET SERVEROUTPUT ON;
COLUMN dt NEW_VALUE vdt
COLUMN db NEW_VALUE vdb
SELECT to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db FROM dual;
SET SERVEROUTPUT ON SIZE UNLIMITED 
SELECT to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio FROM dual;

prompt "-----------------"
prompt "Aplicando Entrega OSF-4725"
prompt "-----------------"
DECLARE
    nuCantAct NUMBER := 0;
    nuPrejcope NUMBER := 117520;
    
    
    CURSOR cuProcejec IS
    SELECT *
    FROM OPEN.procejec
    WHERE prejcope = nuPrejcope 
    AND prejprog IN ('FGCC', 'FGDP');
    
    rcProceject cuProcejec%ROWTYPE;
    
BEGIN    
   
    FOR rcProceject IN cuProcejec LOOP
    
        IF rcProceject.prejprog = 'FGCC' THEN
            UPDATE procejec
            SET prejprog = '_FGCC'
            WHERE prejcope = rcProceject.prejcope
            AND prejprog = 'FGCC';
            
            dbms_output.put_line('Se actualiza prejprog = _FGCC para prejcope = '||nuPrejcope||' y prejprog = FGDP en la tabla Proceject');
        END IF;
        
        IF rcProceject.prejprog = 'FGDP' THEN
            UPDATE procejec
            SET prejprog = '_FGDP'
            WHERE prejcope = rcProceject.prejcope
            AND prejprog = 'FGDP';
            
            dbms_output.put_line('Se actualiza prejprog = _FGDP para prejcope = '||nuPrejcope||' y prejprog = FGDP en la tabla Proceject');
        END IF;
        
        COMMIT;
        nuCantAct := nuCantAct + 1;
    END LOOP;
   
    IF nuCantAct = 0 THEN
        dbms_output.put_line('No se encontraron registros para actualizar');
    END IF;
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('No se pudo actualizar PROCEJECT, '||sqlerrm);
END;
/
prompt "-----------------------"
prompt "-----FINALIZA-----"
prompt "-----------------------"
prompt "-----Fin Aplica Entrega OSF-4725-----"
prompt "-----------------------"
SELECT to_char(sysdate, 'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin FROM dual;
prompt Fin Proceso!!
set serveroutput off
quit
/