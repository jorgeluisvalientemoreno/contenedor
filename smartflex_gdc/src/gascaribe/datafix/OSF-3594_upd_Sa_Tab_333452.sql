column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

	sbCaso				VARCHAR2(30) := 'OSF-3594';
	
	CURSOR cuSaTab
	IS
		SELECT * 
		FROM sa_tab 
		WHERE process_name = 'P_CANCELACION_DE_PROMOCION_327' 
		AND aplica_executable = 'CNCRM';

BEGIN

	dbms_output.put_line('Inicio Datafix OSF-3594');
	
	FOR rcSatab IN cuSaTab LOOP
		
		dbms_output.put_line('Se actualizará la condicion del tab_id: ' || rcSatab.tab_id);
		
		UPDATE sa_tab
		SET condition = ':FECHA_CANCELACION: IS NULL'
		WHERE process_name = rcSatab.process_name
		AND aplica_executable = rcSatab.aplica_executable;
		
		dbms_output.put_line('Se actualizo la condicion ' || rcSatab.condition || ' por :FECHA_CANCELACION: IS NULL');		
		
		COMMIT;		
		
	END LOOP;	
	
	dbms_output.put_line('FIN Datafix OSF-3594');
	
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/