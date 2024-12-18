column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;


BEGIN
  DBMS_OUTPUT.PUT_LINE('Incia Datafix OSF-3497');
  DELETE FROM ldc_inv_ouib where items_id like '4%' or items_id in (100003008 , 100003011);
  DELETE FROM ldc_act_ouib where items_id like '4%' or items_id in (100003008 , 100003011);
  COMMIT; 
  DBMS_OUTPUT.PUT_LINE('Fin Datafix OSF-3497'); 
END;    
/




select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/