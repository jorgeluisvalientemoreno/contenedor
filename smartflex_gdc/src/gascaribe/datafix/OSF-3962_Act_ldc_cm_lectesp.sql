column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

	nuPeriodoFactu	NUMBER	:= 115334;
	nuPeriodoConsu	NUMBER  := 115289; 

BEGIN

	dbms_output.put_line('Inicia OSF-3962');

	UPDATE LDC_CM_LECTESP
	SET PECSCONS = nuPeriodoConsu, 
		PEFACODI = nuPeriodoFactu
	WHERE ORDER_ID IN (350899641,
					   350899645,
					   350899654,
					   350899623,
					   350899644,
					   350899638,
					   350899643
					   );
	
	dbms_output.put_line('Actualizando LDC_CM_LECTESP');

    dbms_output.put_line('Finaliza OSF-3962');
	
	COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        rollback;
        dbms_output.put_line('Error en OSF-3962: '|| SQLERRM);
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/