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
		dbms_output.put_line('Actualizar solicitudes 208116858,208118192,208351575,208900001,208576942,208115656,208521618,208902633,208599230');
		
		UPDATE 	mo_packages
		SET 	sale_channel_id = 4321, person_id = 44422, pos_oper_unit_id = 4321
		WHERE 	package_id in (208116858,208118192,208351575,208900001,208576942,208115656,208521618,208902633,2085992303);
		
		COMMIT;
		
		dbms_output.put_line('Actualizar solicitudes 209264986');
		
		UPDATE 	mo_packages
		SET 	sale_channel_id = 4342, person_id = 38038, pos_oper_unit_id = 4342
		WHERE 	package_id in (209264986);
		
		COMMIT;
				
		dbms_output.put_line('Actualizar solicitudes 208404111');
		
		UPDATE 	mo_packages
		SET 	sale_channel_id = 4585, person_id = 38977, pos_oper_unit_id = 4585
		WHERE 	package_id in (208404111);
		
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