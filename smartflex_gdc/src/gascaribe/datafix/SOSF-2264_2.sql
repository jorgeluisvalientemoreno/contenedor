column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  UPDATE OPEN.CC_SALES_FINANC_COND
  SET INTEREST_PERCENT=37.56,
  VALUE_TO_FINANCE=695084,
  INITIAL_PAYMENT=125000,
  AVERAGE_QUOTE_VALUE=29513
  WHERE PACKAGE_ID IN (209996058);

  commit;

end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/