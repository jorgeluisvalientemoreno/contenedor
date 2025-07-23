column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

Begin

  Begin
  
    update OR_ORDER_ITEMS ooi
       set ooi.order_id = 349249084
     where ooi.order_items_id = 373130673;
    commit;
  
    dbms_output.put_line('Se reemplaza la orden 349249016 por la orden 349249084');
  
  Exception
    when others then
      rollback;
      dbms_output.put_line('Error al reemplazar la orden 349249016 por la orden 349249084: ' ||
                           sqlerrm);
  End;

  Begin
  
    update OR_ORDER_ITEMS ooi
       set ooi.order_id = 349758621
     where ooi.order_items_id = 373658549;
    commit;
  
    dbms_output.put_line('Se reemplaza la orden 349758579 por la orden 349758621');
  
  Exception
    when others then
      rollback;
      dbms_output.put_line('Error al reemplazar la orden 349758579 por la orden 349758621: ' ||
                           sqlerrm);
  End;

  Begin
  
    update OR_ORDER_ITEMS ooi
       set ooi.order_id = 354643584
     where ooi.order_items_id = 378744686;
    commit;
  
    dbms_output.put_line('Se reemplaza la orden 354643493 por la orden 354643584');
  
  Exception
    when others then
      rollback;
      dbms_output.put_line('Error al reemplazar la orden 354643493 por la orden 354643584: ' ||
                           sqlerrm);
  End;

Exception
  when others then
    rollback;
    dbms_output.put_line('Error: ' || sqlerrm);
End;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/