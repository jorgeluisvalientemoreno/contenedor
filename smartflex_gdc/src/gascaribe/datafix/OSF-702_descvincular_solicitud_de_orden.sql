column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  update open.or_order_activity a
     set a.package_id = null
   where a.order_id = 249216019;
  commit;
  dbms_output.put_line('Se desvincula de la orden 249216019 la solicitud 187451542');  
exception
  when no_data_found then
    dbms_output.put_line('No se puedo desvincular de la orden 249216019 la solicitud 187451542');
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/