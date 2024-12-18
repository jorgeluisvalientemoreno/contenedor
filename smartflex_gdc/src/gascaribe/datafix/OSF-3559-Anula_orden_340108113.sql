column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare
	cursor cudatos is
		select o.order_id
		from open.or_order o
		where o.order_id in (340108113);

	  isbOrderComme varchar2(4000) := 'Se anula orden por caso OSF-3559';
	  nuCommentType number := 1277;
	  nuErrorCode   number;
	  sbErrorMesse  varchar2(4000);
begin

	dbms_output.put_line('---- Inicio DATAFIX OSF-3559 ----');
  
	for reg in cudatos loop
		begin
		API_ANULLORDER(reg.order_id,
                       nuCommentType,
					   isbOrderComme,
                       nuErrorCode,
                       sbErrorMesse
					   );
    
		if nuErrorCode = 0 then
			commit;
			dbms_output.put_line('Se anulo la orden: ' || reg.order_id);
		else
			rollback;
			dbms_output.put_line('Error anulando orden: ' || reg.order_id || ' : ' || sbErrorMesse);
		end IF;
		
		exception
			when others then
			dbms_output.put_line('Error anulando orden: ' || reg.order_id || ' : ' || sqlerrm);
			rollback;
		end;
		
	end loop;
  
	dbms_output.put_line('---- Termina DATAFIX OSF-3559 ----');
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/