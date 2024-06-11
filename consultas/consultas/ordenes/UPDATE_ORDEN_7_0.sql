declare
        isbOrderComme   varchar2(4000):='Se cambia estado a 0 por CA 100-9990';
        nuCommentType   number:=1277;
        nuErrorCode       number;
        sbErrorMesse      varchar2(4000);
	cursor cuOrdenes is 
	select order_id , execution_final_date, order_status_id, operating_unit_id
	   from or_order
	  where order_id in (54544843 )
	  and  order_Status_id=7;
begin
	for reg in cuOrdenes loop
		UPDATE OR_ORDER
		   SET ORDER_STATUS_ID=0,
			   ASSIGNED_DATE=NULL,
			   OPERATING_UNIT_ID=NULL,
			   ASSIGNED_WITH=NULL,
			   MAX_DATE_TO_LEGALIZE=NULL,
			   EXEC_INITIAL_DATE=NULL,
			   EXECUTION_FINAL_DATE=NULL
		WHERE ORDER_ID IN (reg.order_id);

		UPDATE OR_ORDER_ACTIVITY
		   SET OPERATING_UNIT_ID=NULL
		  WHERE ORDER_ID IN (reg.order_id);

		OS_ADDORDERCOMMENT (reg.order_id, nuCommentType, isbOrderComme, nuErrorCode,sbErrorMesse);
		   OR_BCORDERSTATCHANG.INSRECORD(
			reg.order_id,
			OR_BOCONSTANTS.CNUORDER_ACTION_ASSIGN,
			REG.ORDER_STATUS_ID,
			0,
			reg.execution_final_date,
			null,
			null,
			null,
			NULL,
			OR_BOORDERCOMMENT.FNUGETLASTCOMMTYPE,
			NULL,
			sysdate);
	end loop;
  
exception
  when others then
	dbms_output.put_line(sbErrorMesse);
end;
/
