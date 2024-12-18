set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
  i number;
BEGIN

  UPDATE open.or_order oo
     set oo.causal_id = 1529
   where oo.order_id = 310133395;

  COMMIT;
  dbms_output.put_line('Cambio de causal de la orden 310133395');

exception
  when others then
    dbms_output.put_line('Error: ' || sqlerrm);
  
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/