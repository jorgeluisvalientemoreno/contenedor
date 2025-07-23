column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

BEGIN
  
  UPDATE open.Or_Order_Activity ooa
    set ooa.address_id = 397
  where ooa.order_id in (346743443, 347637691);
  COMMIT;
  dbms_output.put_line('Se actaliza direccion de las ordenes 346743443 y 347637691 Ok.');

exception
  when others then
    rollback;
    dbms_output.put_line('No se pudo actaliza direccion de las ordenes 346743443 y 347637691 Error: ' ||
                         sqlerrm);
  
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/