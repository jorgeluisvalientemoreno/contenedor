DECLARE
isbOrderComme   varchar2(4000):='Se reversa ejecucion por GLPI 2020100137';
nuCommentType   number:=1277;
nuErrorCode       number;
sbErrorMesse      varchar2(4000);

CURSOR cuOrdenes is
select o.order_id,o.order_status_id, o.created_date, o.assigned_date,  o.operating_unit_id, open.daor_operating_unit.fsbgetname(o.operating_unit_id),
 u.contractor_id, o.task_type_id,open.daor_task_type.fsbgetdescription(o.task_type_id), o.programing_class_id
from open.or_order o, open.or_operating_unit u
where o.order_status_id=7
  and o.operating_unit_id=u.operating_unit_id
  and O.order_id in (180571244 , 180571220 , 180571231 , 180571219 , 180571224 , 180571232 , 180571225 , 180690071 , 180690070 , 180690058 , 180690072 ,
                     180690068 , 180690069 , 180690065 , 180690066 , 180690061)
  and u.contractor_id is not null;
  
  
	rcOperUnitRecord    daor_operating_unit.styOR_operating_unit;
	nuTotalUsedCapacity number;
	cnuTOT_SEG_MINU     constant number := 60 ;
	nuOrderDuration     number := 0;
	
	rcStatChange    daor_order_stat_change.styOr_order_stat_change;
	nuFinalStatusId or_order.order_status_id%type:=0;
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
		
			rcStatChange.order_stat_change_id  := or_bosequences.fnuNextOr_Order_Stat_Change;
			rcStatChange.initial_status_id := reg.order_status_id;
			rcStatChange.final_status_id := nuFinalStatusId;
			rcStatChange.order_id := reg.order_id;
			rcStatChange.stat_chg_date := sysdate;
			rcStatChange.user_id := ut_session.getUSER;
			rcStatChange.terminal := ut_session.getTERMINAL;
			rcStatChange.comment_type_id := nuCommentType;
			rcStatChange.execution_date := null;
			rcStatChange.initial_oper_unit_id := reg.operating_unit_id;
			rcStatChange.range_description := null;
			rcStatChange.programing_class_id := null;
			rcStatChange.action_id := OR_boconstants.cnuORDER_ACTION_UNPROG;
			rcStatChange.final_oper_unit_id := null;

		update or_order
		   set assigned_date=null,
			 exec_estimate_date=null,
			 assigned_with=null,
			 max_date_to_legalize=null,
			 operating_unit_id=null,
			 causal_id=null,
			 order_status_id=0
		where order_id=reg.order_id;

		update or_order_activity
		   set operating_unit_id=null
		where order_id=reg.order_id;
		daor_order_stat_change.insrecord(rcStatChange);
		OS_ADDORDERCOMMENT (reg.order_id, nuCommentType, isbOrderComme, nuErrorCode,sbErrorMesse);
		COMMIT;
	exception
		when others then
			rollback;
			dbms_output.put_line('Error al actualizar la orden : '||reg.order_id||'- '||sqlerrm);
	end;
  end loop;
  commit;
END;
/
