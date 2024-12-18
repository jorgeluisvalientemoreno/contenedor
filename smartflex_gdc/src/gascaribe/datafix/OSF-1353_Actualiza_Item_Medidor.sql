column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

BEGIN
	dbms_output.put_line('------------------- Inicio OSF-1353 -------------------');

	UPDATE 	ge_items_seriado
	SET		items_id = 10004070, serie = 'S-726599-NO-USAR-SOSF-1759'
	WHERE 	serie = 'S-726599';
	
	UPDATE 	elemmedi
	SET		elmecodi = 'S-726599-NO-USAR-SOSF-1759'
	WHERE 	elmecodi = 'S-726599';
	
	UPDATE 	elmesesu
	SET 	emsscoem = 'S-726599-NO-USAR-SOSF-1759'
	WHERE 	emsscoem LIKE 'S-726599%';
	
	COMMIT;
	dbms_output.put_line('------------------- Actualizacion OK -------------------');
  
	dbms_output.put_line('------------------- Fin OSF-1353 -------------------');
EXCEPTION
	WHEN OTHERS THEN
		ROLLBACK;
		dbms_output.put_line('---- Error OSF-1353 ----');
		dbms_output.put_line('OSF-1353-Error General: --> '||sqlerrm);
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/