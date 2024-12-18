set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
BEGIN
	UPDATE open.servsusc
	SET 	sesucicl = 1801, sesucico = 1801
	WHERE   sesunuse = 52421754;
	
	COMMIT;
END;
/
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/