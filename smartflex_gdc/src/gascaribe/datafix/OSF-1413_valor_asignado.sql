column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

	nuerror NUMBER;
    sberror VARCHAR2(4000);
	nuCommentType or_order_comment.comment_type_id%type := 1277;

	CURSOR cuValorAsignado IS
		select sum(estimated_cost) estimated_cost, 
			   defined_contract_id 
		from or_order
		where defined_contract_id	in (6901, 9401, 9441, 9421, 5541, 9501, 6801) 
		and order_status_id in (5, 7)
		group by defined_contract_id;

begin
  dbms_output.put_line('Inicia OSF-1413');
  
  BEGIN
  
  FOR reg IN cuValorAsignado LOOP
	
	dbms_output.put_line('El valor asignado del contrato: ' || reg.defined_contract_id || ' es: ' || reg.estimated_cost);
	
	update ge_contrato
	set valor_asignado = reg.estimated_cost
	where id_contrato = reg.defined_contract_id;
	
	commit;
     
  END LOOP;
  
  EXCEPTION
	WHEN OTHERS THEN 
	rollback; 
	DBMS_OUTPUT.PUT_LINE('Error no controlado --> '||sqlerrm); 
  END;
  
  dbms_output.put_line('Termina OSF-1413');
  
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/