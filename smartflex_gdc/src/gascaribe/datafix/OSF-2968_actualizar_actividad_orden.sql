column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set linesize 1000
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  DECLARE
    nuErrorCode      NUMBER;
    sbErrorMessage   VARCHAR2(4000);
    nuEjecucionFlujo NUMBER := 0;
  BEGIN
  
    update open.or_order_activity ooa
       set ooa.activity_id = 100009058
     where ooa.order_id = 298478381
       and ooa.activity_id = 100009057;
  
    update open.or_order_items ooi
       set ooi.items_id = 100009058
     where ooi.order_id = 298478381
       and ooi.items_id = 100009057;
  
    commit;
    dbms_output.put_line('Se actualiza actividad 100009057 por la nueva actividad 100009058 de la orden 298478381 en caso OSF-2968');
  
  exception
    when others then
      rollback;
      dbms_output.put_line('Error: ' || sqlerrm);
  END;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/

