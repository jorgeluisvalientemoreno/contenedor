set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
  i number;
BEGIN

  UPDATE open.or_order oo
     set oo.causal_id = 3146
   where oo.order_id = 350612615;

  COMMIT;
  dbms_output.put_line('Cambio de causal 3147 – No se incurre en Silencio Administrativo Positivo a la nueva causal 3146 - Se incurrió en Silencio Adnministrativo en la orden 350612615');

exception
  when others then
    rollback;
    dbms_output.put_line('Error: ' || sqlerrm);
  
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/