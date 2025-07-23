column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

	nuPeriodoFactu	NUMBER	:= 115265;
	nuPeriodoConsu	NUMBER  := 115220; 

BEGIN

	dbms_output.put_line('Inicia OSF-3951');

	UPDATE lectelme 
	SET leempefa = nuPeriodoFactu,
		leempecs = nuPeriodoConsu
	WHERE leemsesu = 52837707 
	AND leempecs = 115246;
	
	dbms_output.put_line('Actualizando lectelme');
	
	UPDATE conssesu 
	SET cosspefa = nuPeriodoFactu,
		cosspecs = nuPeriodoConsu
	WHERE cosssesu = 52837707 
	AND cosspecs = 115246;
	
	dbms_output.put_line('Actualizando conssesu');

    dbms_output.put_line('Finaliza OSF-3951');
	
	COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        rollback;
        dbms_output.put_line('Error en OSF-3951: '|| SQLERRM);
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/