set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
isbOrderComme   varchar2(4000):='Se actuliza unidad operativa por caso SOSF-919';
nuCommentType   number:=1277;
nuErrorCode     number;
sbErrorMesse    varchar2(4000);

CURSOR cuOrdenes is
select o.order_id,o.order_status_id, o.created_date, o.assigned_date,  o.operating_unit_id, open.daor_operating_unit.fsbgetname(o.operating_unit_id),
 u.contractor_id, o.task_type_id,open.daor_task_type.fsbgetdescription(o.task_type_id)
from open.or_order o, open.or_operating_unit u
where o.order_status_id=7
  and o.operating_unit_id=u.operating_unit_id
  and o.order_id in (131158547,
                     131158548,
                     133817879,
                     133817880,
                     133817881,
                     133817882,
                     133817883,
                     142050287) and o.task_type_id = 12178;

  rcOperUnitRecord    daor_operating_unit.styOR_operating_unit;
  nuTotalUsedCapacity number;
  cnuTOT_SEG_MINU     constant number := 60 ;
  nuOrderDuration     number := 0;
BEGIN
  for reg in cuOrdenes loop
    begin

      --se actualiza la unidad de or_order
      update or_order
        set operating_unit_id=3745
      where order_id=reg.order_id;
      
      --se actualiza la unidad de or_order_activity
      update or_order_activity
      set operating_unit_id=3745
      where order_id=reg.order_id;

      OS_ADDORDERCOMMENT (reg.order_id, nuCommentType, isbOrderComme, nuErrorCode,sbErrorMesse);
      if nuErrorCode= 0 then
        commit;
        --rollback;
        dbms_output.put_line(reg.order_id||'|'||'PROCESADA OK');
      else
        rollback;
        dbms_output.put_line(reg.order_id||'|'||'ERROR: '||sbErrorMesse);
      end if;
    exception
      when others then
        rollback;
        dbms_output.put_line(reg.order_id||'|'||'ERROR: '||sqlerrm);
    end;
  end loop;
END;

/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/