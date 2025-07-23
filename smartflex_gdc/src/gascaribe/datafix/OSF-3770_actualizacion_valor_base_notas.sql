column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

BEGIN

	dbms_output.put_line('Inicia OSF-3770');

		UPDATE cargos SET cargvabl = 606 WHERE cargcuco = 3074031242 AND cargcodo = 158597682 AND cargconc = 1035;
		UPDATE cargos SET cargvabl = 45265 WHERE cargcuco = 3070764694 AND cargcodo = 158597928 AND cargconc = 1035;
		UPDATE cargos SET cargvabl = 60478 WHERE cargcuco = 3072729980 AND cargcodo = 158597929 AND cargconc = 1035;
		UPDATE cargos SET cargvabl = 51989 WHERE cargcuco = 3074031311 AND cargcodo = 158597930 AND cargconc = 1035;
		UPDATE cargos SET cargvabl = 972138 WHERE cargcuco = 3072729920 AND cargcodo = 158597663 AND cargconc = 1035;
		UPDATE cargos SET cargvabl = 835677 WHERE cargcuco = 3074031275 AND cargcodo = 158597664 AND cargconc = 1035;
	  COMMIT;
  
	dbms_output.put_line('Finaliza OSF-3770');
  
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/