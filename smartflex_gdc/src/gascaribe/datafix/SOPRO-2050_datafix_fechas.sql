column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;
BEGIN
     UPDATE "OPEN".LDC_OTLEGALIZAR
        SET EXEC_INITIAL_DATE = TO_DATE('2022-09-17 10:32:00', 'YYYY-MM-DD HH24:MI:SS'),
        EXEC_FINAL_DATE = TO_DATE('2022-09-17 10:44:00', 'YYYY-MM-DD HH24:MI:SS')
        WHERE ORDER_ID = 259397457;
    UPDATE "OPEN".LDC_OTLEGALIZAR
        SET EXEC_INITIAL_DATE = TO_DATE('2022-10-01 13:01:00', 'YYYY-MM-DD HH24:MI:SS'),
        EXEC_FINAL_DATE = TO_DATE('2022-10-01 13:04:00', 'YYYY-MM-DD HH24:MI:SS')
        WHERE ORDER_ID = 261013220;

    UPDATE "OPEN".OR_ORDER
        SET EXEC_INITIAL_DATE=TIMESTAMP '2022-09-17 10:32:00.000000',
        EXECUTION_FINAL_DATE=TIMESTAMP '2022-09-17 10:44:00.000000'
        WHERE ORDER_ID=	259397457;
    UPDATE "OPEN".OR_ORDER
        SET EXEC_INITIAL_DATE=TIMESTAMP '2022-10-01 13:01:00.000000',
        EXECUTION_FINAL_DATE=TIMESTAMP '2022-10-01 13:04:00.000000'
        WHERE ORDER_ID=	261013220;
    COMMIT;
 END;
/
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/
