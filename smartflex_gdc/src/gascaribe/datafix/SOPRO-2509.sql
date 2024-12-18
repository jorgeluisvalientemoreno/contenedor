column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;


begin
  UPDATE "OPEN".OR_ORDER
        SET EXEC_INITIAL_DATE=TIMESTAMP '2023-01-12 11:54:53.000000'
        WHERE ORDER_ID=	272147820;

  UPDATE LDC_OTLEGALIZAR SET EXEC_INITIAL_DATE=TO_DATE('12/01/2023 11:54:53','DD/MM/YYYY HH24:MI:SS') WHERE ORDER_ID=272147820;
  commit;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/