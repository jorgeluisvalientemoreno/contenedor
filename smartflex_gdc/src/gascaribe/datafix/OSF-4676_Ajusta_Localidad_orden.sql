column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;


BEGIN
  dbms_output.put_line('Inicia OSF-4676');

	UPDATE or_order_activity
	SET 	address_id = 397
	WHERE  order_id = 366543222;
  
	COMMIT;
  DBMS_OUTPUT.PUT_LINE('Termina OSF-4676'); 
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/