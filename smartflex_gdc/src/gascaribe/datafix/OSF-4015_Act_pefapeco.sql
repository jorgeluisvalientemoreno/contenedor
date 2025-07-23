column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

	nuPeriodoFactu	NUMBER	:= 115887;
	nuPeriodoConsu	NUMBER  := 115842; 

BEGIN

	dbms_output.put_line('Inicia OSF-4015');

	UPDATE lectelme 
	SET leempefa = nuPeriodoFactu,
		leempecs = nuPeriodoConsu
	WHERE leemsesu IN (52903402,52908238)
	AND leempecs = 115878;
	
	dbms_output.put_line('Actualizando lectelme');
	
	UPDATE conssesu 
	SET cosspefa = nuPeriodoFactu,
		cosspecs = nuPeriodoConsu
	WHERE cosssesu IN (52903402,52908238) 
	AND cosspecs = 115878;
	
	dbms_output.put_line('Actualizando conssesu');

    dbms_output.put_line('Finaliza OSF-4015');
	
	COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        rollback;
        dbms_output.put_line('Error en OSF-4015: '|| SQLERRM);
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/