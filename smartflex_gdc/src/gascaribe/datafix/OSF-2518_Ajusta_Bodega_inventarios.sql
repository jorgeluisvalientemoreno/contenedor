column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin

	dbms_output.put_line('Inicia datatix OSF-2518');
  
	UPDATE ldc_inv_ouib
	SET quota 	= 60,
	    balance	= 1
	WHERE items_id 			= 10002017
    AND operating_unit_id 	= 4606;
	
	dbms_output.put_line('Se actualiza el inventario del ítem 10002017 unidad 4606');
	
	UPDATE ldc_inv_ouib
	SET balance	= 7
	WHERE items_id 			= 10002017
    AND operating_unit_id 	= 4604;
	
	dbms_output.put_line('Se actualiza el inventario del ítem 10002017 unidad 4604');
	
	UPDATE ldc_act_ouib
	SET balance	= 0
	WHERE items_id 			= 10002017
    AND operating_unit_id 	= 4604;
	
	dbms_output.put_line('Se actualiza el activo del ítem 10002017 unidad 4604');
	
	UPDATE ldc_inv_ouib
	SET quota 	= 100
	WHERE items_id 			= 10002011
    AND operating_unit_id 	= 4606;
	
	dbms_output.put_line('Se actualiza el inventario del ítem 10002011 unidad 4606');
	
	UPDATE ldc_inv_ouib
	SET balance	= 12
	WHERE items_id 			= 10002011
    AND operating_unit_id 	= 4604;
	
	dbms_output.put_line('Se actualiza el inventario del ítem 10002011 unidad 4604');
	
	UPDATE ldc_act_ouib
	SET balance	= 0
	WHERE items_id 			= 10002011
    AND operating_unit_id 	= 4604;
	
	dbms_output.put_line('Se actualiza el activo del ítem 10002011 unidad 4604');
  
	commit;
  
	dbms_output.put_line('Finaliza datatix OSF-2518 ');
  
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/