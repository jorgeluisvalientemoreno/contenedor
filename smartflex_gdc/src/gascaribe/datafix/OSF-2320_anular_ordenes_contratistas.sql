column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

	nuCodigoError 		NUMBER;
    sbMensajeError 		VARCHAR2(4000);

BEGIN
	dbms_output.put_line('Inicia OSF-2314');
  
	BEGIN
		dbms_output.put_line('Actualizar solicitudes 208599230');
		
		UPDATE 	mo_packages
		SET 	sale_channel_id = 4321, person_id = 44422, pos_oper_unit_id = 4321
		WHERE 	package_id in (208599230);
		
		COMMIT;
		
	EXCEPTION
		WHEN OTHERS THEN
			Pkg_error.seterror;
			Pkg_error.geterror(nuCodigoError, sbMensajeError);
			dbms_output.put_line(sbMensajeError);
	END;
	
	dbms_output.put_line('Fin OSF-2314');

END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/