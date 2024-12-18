column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare
    cursor cuordenes is
        SELECT Order_id, package_id
		FROM or_order_activity
		WHERE order_id IN (306963545, 305195966);
		
	nuCommentType	CONSTANT NUMBER := 83;
	nuErrorCode     NUMBER;
	sbErrorMesse    VARCHAR2(4000);

begin

	dbms_output.put_line('Inicia OSF-2085');
	
	FOR reg IN cuordenes LOOP
	
		dbms_output.put_line('Desasociando la solicitud: ' || reg.package_id || ' de la orden: ' || reg.order_id);
		
		update or_order_activity
		set package_id = NULL
		WHERE order_id = reg.order_id;
		
		UPDATE OR_EXTERN_SYSTEMS_ID
		SET package_id = NULL
		WHERE order_id = reg.order_id;
		
		dbms_output.put_line('Agregando el comentario a la orden: ' || reg.order_id);
		
		api_anullorder(reg.order_id, 
					   nuCommentType, 
					   'Se desasocia la solicitud ' || reg.package_id || ' de la orden ' || reg.order_id || ' por el caso SOSF-2139',
					   nuErrorCode, 
					   sbErrorMesse
					   );
					 
		commit;
	
	END LOOP;
	
	dbms_output.put_line('Finaliza OSF-2085');
  
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/