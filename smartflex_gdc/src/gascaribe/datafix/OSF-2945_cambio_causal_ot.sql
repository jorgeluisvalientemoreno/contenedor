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
  
    update open.or_order oo
       set oo.causal_id = 9287
     where oo.order_id in (331480828, 331480816);

    update open.or_order_items ooi
       set ooi.legal_item_amount = 1
     where ooi.order_id in (331480828, 331480816);

    delete open.or_order_comment ooc
     where ooc.order_id in (331480828, 331480816);
  
    commit;
    dbms_output.put_line('Se actualiza causal y retira comentario de las ordenes 331480828 y 331480816 solicitado por funcional en caso OSF-2945');
  
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

