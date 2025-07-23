column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

BEGIN

	dbms_output.put_line( 'Inicia OSF-4066' );

	UPDATE ge_items_seriado
	SET subscriber_id = 2287821
	WHERE serie = 'J-79476-23'
	AND id_items_seriado = 2678376
	AND subscriber_id = 1920032;
	
	UPDATE elmesesu
	SET emsssesu = 52112191 
	WHERE emsscoem = 'J-79476-23'
	AND emsssesu = 51520265;
	
	UPDATE lectelme
	SET leemsesu = 52112191
	WHERE leemsesu = 51520265
	AND leemelme = 2677078;
	
	COMMIT;
	dbms_output.put_line( 'Fin OSF-4066' );
	
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/