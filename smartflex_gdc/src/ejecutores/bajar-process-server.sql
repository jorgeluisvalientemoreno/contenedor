column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
    nuThreadCount number;
    nuServerCount number;
BEGIN
    SELECT count(*) INTO nuThreadCount
    FROM v$session
    WHERE module='EXECUTOR_PROCESS';
    SELECT count(*) INTO nuServerCount
    FROM v$session
    WHERE module='PROCESS_SERVER';
    IF(nuThreadCount=0)
    THEN
        IF(nuServerCount=0)
        THEN
            dbms_output.put_Line('El proceso servidor ya se encuentra abajo.');
        ELSE
            dbms_output.put_Line('Se procede a bajar el proceso servidor, por favor espere.');
            ge_bosystemprocessmonitor.sendshutdownserver();
        END IF;
    ELSE
        dbms_output.put_Line('No se puede bajar el proceso servidor hasta que todos los hilos no se encuentren abajo.'
        ||chr(10)||'Si ya ejecutM-s el proceso de bajado de hilos por favor espere a que todos se encuentren abajo.'
        ||chr(10)||'Si no lo ha ha hecho, ejecute primero el proceso de bajado de hilos.');
    END IF;
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/
