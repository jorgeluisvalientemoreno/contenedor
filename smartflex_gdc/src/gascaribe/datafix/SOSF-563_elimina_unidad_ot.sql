set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
isbOrderComme   varchar2(4000):='Se quita unidad operativa por caso SOSF-563';
nuCommentType   number:=1277;
nuErrorCode     number;
sbErrorMesse    varchar2(4000);

CURSOR cuOrdenes is
select o.order_id,o.order_status_id, o.created_date, o.assigned_date,  o.operating_unit_id, open.daor_operating_unit.fsbgetname(o.operating_unit_id),
 u.contractor_id, o.task_type_id,open.daor_task_type.fsbgetdescription(o.task_type_id)
from open.or_order o, open.or_operating_unit u
where o.order_status_id=11
  and o.operating_unit_id=u.operating_unit_id
  and o.order_id=184426103
  and u.contractor_id is not null
  and not exists(
      select null
       from open.ct_tasktype_contype tc, open.ge_contrato co
     where o.task_type_id= tc.task_type_id
       and tc.contract_type_id=co.id_tipo_contrato
       and co.id_contratista=u.contractor_id
       and co.status='AB'
       and co.fecha_final>=trunc(sysdate));

	rcOperUnitRecord    daor_operating_unit.styOR_operating_unit;
	nuTotalUsedCapacity number;
	cnuTOT_SEG_MINU     constant number := 60 ;
	nuOrderDuration     number := 0;
BEGIN
  for reg in cuOrdenes loop
    begin
      daor_operating_unit.GetRecord(reg.operating_unit_id, rcOperUnitRecord);
      nuTotalUsedCapacity :=  nvl(rcOperUnitRecord.Used_Assign_Cap,0);
      nuOrderDuration := OR_BCOptimunRoute.fnuCalcularDuracion(reg.order_id);
      nuOrderDuration := nvl(nuOrderDuration/cnuTOT_SEG_MINU,0);
      if nvl(nuOrderDuration,0) > 0 and nuTotalUsedCapacity - nuOrderDuration > 0 then
        nuTotalUsedCapacity := nuTotalUsedCapacity - nuOrderDuration;
        daor_operating_unit.updUsed_Assign_Cap(reg.operating_unit_id,nuTotalUsedCapacity);
      end if;
      update or_order
        set assigned_date=null,
          exec_estimate_date=null,
          assigned_with=null,
          max_date_to_legalize=null,
          operating_unit_id=null,
          prev_order_status_id=0
      where order_id=reg.order_id;
      
      --se borra la unidad de or_order_activity
      update or_order_activity
      set operating_unit_id=null
      where order_id=reg.order_id;

      OS_ADDORDERCOMMENT (reg.order_id, nuCommentType, isbOrderComme, nuErrorCode,sbErrorMesse);
      if nuErrorCode= 0 then
        commit;
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