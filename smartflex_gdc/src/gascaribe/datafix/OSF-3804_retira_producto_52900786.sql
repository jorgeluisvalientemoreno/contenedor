column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin

	dbms_output.put_line('Inicia datafix OSF-3804');
	
	dbms_output.put_line('Retirando el producto 52900786');
	
	UPDATE servsusc
	SET sesuesco = 95, 
		sesufere = SYSDATE
	WHERE sesususc 	= 67578393
	AND sesuserv 	= 6121;
	
	UPDATE pr_product
	SET product_status_id 	= 3, 
		retire_date 		= SYSDATE
	WHERE subscription_id 	= 67578393
	AND product_type_id 	= 6121;
	
	commit;
	
	dbms_output.put_line('Finaliza datafix OSF-3804');
	
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/