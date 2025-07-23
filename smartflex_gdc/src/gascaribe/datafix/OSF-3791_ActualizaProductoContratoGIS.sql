column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

	cursor cuordenes 
	is
		SELECT * 
		FROM or_order_activity 
		WHERE order_id IN (340167726);

begin
  
	dbms_output.put_line('Inicia OSF-3791');

	FOR reg IN cuordenes LOOP
  
		begin
    
			update or_order_activity
			set product_id = 52516670, subscription_id = 67343274
			WHERE order_id = reg.order_id;
    
			UPDATE OR_EXTERN_SYSTEMS_ID
			SET product_id = 52516670, subscription_id = 67343274
			WHERE order_id = reg.order_id;
    
			commit;
		
		dbms_output.put_line('Actualizar producto y contrasto en la orden: ' || reg.order_id);
    
		exception
			when others then
			rollback;
			dbms_output.put_line('No se actualiza producto y contrasto en la orden: ' || reg.order_id || ' - Error: ' || sqlerrm);
		end;
	END LOOP;

	dbms_output.put_line('Finaliza OSF-3791');

end;
/
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/