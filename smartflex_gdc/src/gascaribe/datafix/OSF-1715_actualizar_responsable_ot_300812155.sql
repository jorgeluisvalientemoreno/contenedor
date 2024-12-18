column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  UPDATE open.or_order_person oop
     SET oop.person_id = 13542
   WHERE oop.order_id = 300812155;
  commit;
  dbms_output.put_line('Se actualizo responable 13546 - JAIRO JOSE DAZA por 13542 - AUGUSTO DONADO de la orden 300812155');
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/