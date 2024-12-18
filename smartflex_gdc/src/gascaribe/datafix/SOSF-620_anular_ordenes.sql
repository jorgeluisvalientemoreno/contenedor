column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare
  cursor cudatos is
    select a.package_id,
           a.product_id,
           a.subscription_id,
           o.order_id,
           o.created_date,
           o.order_status_id,
           o.operating_unit_id
      from open.or_order_activity a, open.or_order o
     where a.ORDER_ID in (258231621,258283839)
       and a.order_id = o.order_id
     order by package_id;

  isbOrderComme varchar2(4000) := 'Se cambia estado a anulado por caso SOSF-620';
  nuCommentType number := 1277;
  nuErrorCode   number;
  sbErrorMesse  varchar2(4000);
begin
  for reg in cudatos loop
    begin
    
      dbms_output.put_line('Orden: ' || reg.order_id);
      or_boanullorder.anullorderwithoutval(reg.order_id, SYSDATE);
    
      OS_ADDORDERCOMMENT(reg.order_id,
                         nuCommentType,
                         isbOrderComme,
                         nuErrorCode,
                         sbErrorMesse);
      if nuErrorCode = 0 then
        commit;
        dbms_output.put_line('Se anulo OK orden: ' || reg.order_id);
      else
        rollback;
        dbms_output.put_line('Error anulando orden: ' || reg.order_id ||
                             ' : ' || sbErrorMesse);
      end IF;
    exception
      when others then
        dbms_output.put_line('Error anulando orden: ' || reg.order_id ||
                             ' : ' || sqlerrm);
        rollback;
    end;
  end loop;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/