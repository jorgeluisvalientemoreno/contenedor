set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;
/
BEGIN
	
	update cargos set cargvabl = 178519
	where cargcodo = 158699401 and cargconc = 1035;
	
	COMMIT;
END;
/
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/