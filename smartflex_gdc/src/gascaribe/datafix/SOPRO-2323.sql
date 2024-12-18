column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  UPDATE LDC_OTLEGALIZAR SET EXEC_INITIAL_DATE=TO_DATE('14/09/2022 15:36:44','DD/MM/YYYY HH24:MI:SS'), EXEC_FINAL_DATE = TO_DATE('14/09/2022 15:56:44','DD/MM/YYYY HH24:MI:SS') WHERE ORDER_ID=259117609;
  UPDATE LDC_OTLEGALIZAR SET EXEC_INITIAL_DATE=TO_DATE('8/11/2022 9:24:13','DD/MM/YYYY HH24:MI:SS'), EXEC_FINAL_DATE = TO_DATE('8/11/2022 9:44:13','DD/MM/YYYY HH24:MI:SS') WHERE ORDER_ID=263778176;
  UPDATE LDC_OTLEGALIZAR SET EXEC_INITIAL_DATE=TO_DATE('8/11/2022 9:24:31','DD/MM/YYYY HH24:MI:SS'), EXEC_FINAL_DATE = TO_DATE('8/11/2022 9:44:31','DD/MM/YYYY HH24:MI:SS') WHERE ORDER_ID=263778144;
  commit;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/