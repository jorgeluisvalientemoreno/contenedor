column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX OSF-1568');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

BEGIN
	dbms_output.put_line('Iniciando datafix OSF-1568');
	dbms_output.put_line('Realizar cambio de medidor cm_bochangemeter.changemeter');
	
	cm_bochangemeter.changemeter('S-951487-23', 14523467, 2852113, 'S-951520-23', 51466117, 5413882);
	
	COMMIT;

	dbms_output.put_line('Fin OSF-1568');
END;
/
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/