SET SERVEROUTPUT ON;
COLUMN dt NEW_VALUE vdt
COLUMN db NEW_VALUE vdb
SELECT to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db FROM dual;
SET SERVEROUTPUT ON SIZE UNLIMITED 
SELECT to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio FROM dual;

prompt "-----------------"
prompt "Aplicando Entrega OSF-3999"
prompt "-----------------"

BEGIN
    dbms_output.put_line('Actualizar registros en ge_statement');
    
    UPDATE OPEN.ge_statement
    SET STATEMENT = REPLACE(STATEMENT, 'LD_BORTAINTERACCION','pkg_bosolicitud_interaccion')
    WHERE DESCRIPTION = 'Tipo de Respuesta Electrónica'
    AND UPPER(STATEMENT) LIKE '%LD_BORTAINTERACCION%';    
                    
    COMMIT;
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('No se pudo actualizar registro en ge_statement, '||sqlerrm);
END;
/
prompt "-----------------------"
prompt "-----FINALIZA-----"
prompt "-----------------------"
prompt "-----Fin Aplica Entrega OSF-3999-----"
prompt "-----------------------"
SELECT to_char(sysdate, 'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin FROM dual;
prompt Fin Proceso!!
set serveroutput off
quit
/