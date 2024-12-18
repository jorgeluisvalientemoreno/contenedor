column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;


BEGIN
  DELETE OPEN.ldc_act_ouib b  where b.items_id=10002017 and b.operating_unit_id in (3503);
  DELETE OPEN.ldc_inv_ouib b  where b.items_id=10002017 and b.operating_unit_id in (3503);
  commit;  
END;    
/




select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/