column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

  cursor cuordenes is
    SELECT * FROM open.or_order_activity WHERE order_id IN (333777344);

begin
  dbms_output.put_line('Inicia OSF-3277');

  FOR reg IN cuordenes LOOP
  
    begin
    
      update open.or_order_activity
         set product_id = 51546201, subscription_id = 66689972
       WHERE order_id = reg.order_id;
    
      UPDATE open.OR_EXTERN_SYSTEMS_ID
         SET product_id = 51546201, subscription_id = 66689972
       WHERE order_id = reg.order_id;
    
      commit;
      dbms_output.put_line('Actualizar producto y contrasto en la orden: ' ||
                           reg.order_id);
    
    exception
      when others then
        rollback;
        dbms_output.put_line('No se actualiza producto y contrasto en la orden: ' ||
                             reg.order_id || ' - Error: ' || sqlerrm);
    end;
  END LOOP;

  dbms_output.put_line('Finaliza OSF-3277');

end;
/


select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/