column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

	nuSolicitud 	NUMBER;
	dtFechaAtencion	DATE;
	
	cursor cuSolicitud
	IS
		select package_id, attention_date 
		from mo_packages 
		where package_id = 110609842;
		
begin

	dbms_output.put_line('Inicia datafix OSF-3750');
	
	IF (cuSolicitud%ISOPEN) THEN
		CLOSE cuSolicitud;
    END IF;
	
	OPEN cuSolicitud;
    FETCH cuSolicitud INTO nuSolicitud, dtFechaAtencion;
    CLOSE cuSolicitud;
	
	dbms_output.put_line('La solicitud ' || nuSolicitud || ' fue atendida el día ' || dtFechaAtencion);
	
	dbms_output.put_line('Retirando el producto 51839619');
	
	UPDATE servsusc
	SET sesuesco = 95, 
		sesufere = dtFechaAtencion
	WHERE sesususc 	= 48152207
	AND sesuserv 	= 6121;
	
	UPDATE pr_product
	SET product_status_id 	= 3, 
		retire_date 		= dtFechaAtencion
	WHERE subscription_id 	= 48152207
	AND product_type_id 	= 6121;
	
	commit;
	
	dbms_output.put_line('Finaliza datafix OSF-3750');
	
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/