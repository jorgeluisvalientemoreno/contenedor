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
	dbms_output.put_line('Inicia OSF-1625');
  
	BEGIN
		dbms_output.put_line('Actualizar solicitudes 197113363,197890157,198842783,204377803');
		
		UPDATE 	mo_packages
		SET 	sale_channel_id = 4341, person_id = 16788, pos_oper_unit_id = 4341
		WHERE 	package_id in (197113363,197890157,198842783,204377803);
		
		COMMIT;
		
		dbms_output.put_line('Actualizar solicitudes 197389244,198189805,199719101,202057095,201933213,203079519,203211565,203721961,203838268,202545137,204172612');
		
		UPDATE 	mo_packages
		SET 	sale_channel_id = 4342, person_id = 38038, pos_oper_unit_id = 4342
		WHERE 	package_id in (197389244,198189805,199719101,202057095,201933213,203079519,203211565,203721961,203838268,202545137,204172612);
		
		COMMIT;
				
		dbms_output.put_line('Actualizar solicitudes 203722231,203840464,204437052');
		
		UPDATE 	mo_packages
		SET 	sale_channel_id = 4321, person_id = 44422, pos_oper_unit_id = 4321
		WHERE 	package_id in (203722231,203840464,204437052);
		
		COMMIT;
		
	EXCEPTION
		WHEN OTHERS THEN
			Pkg_error.seterror;
			Pkg_error.geterror(nuCodigoError, sbMensajeError);
			dbms_output.put_line(sbMensajeError);
	END;
	
	dbms_output.put_line('Fin OSF-1625');

END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/