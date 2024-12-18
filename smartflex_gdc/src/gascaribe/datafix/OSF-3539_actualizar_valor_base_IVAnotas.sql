set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;
/
BEGIN
	
	UPDATE cargos SET cargvabl = 36957 WHERE rowid = 'AACIYwAKyAAI7olAAV';
	
	COMMIT;
END;
/
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/