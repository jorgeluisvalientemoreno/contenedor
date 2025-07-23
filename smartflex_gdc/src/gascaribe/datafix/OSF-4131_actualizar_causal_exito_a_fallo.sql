column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  update or_order
     set causal_id = 3628
    where order_id = 336822191;

  UPDATE or_order_items ooi
     SET ooi.legal_item_amount = 0
   WHERE ooi.order_id = 336822191;

    commit;
    dbms_output.put_line('Se actualiza orden 336822191 cambiando la causal de 3627 - CUANDO SE DIBUJA CON EXITO LA UC a la nueva causal 3628 - CUANDO NO SE DIBUJA CON EXITO LA UC');
exception
  when others then
     rollback;
     dbms_output.put_line('Error: '||sqlerrm);
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/