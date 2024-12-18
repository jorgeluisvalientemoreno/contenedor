column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
	gsbChainJobsPBMAFA  VARCHAR2(30) := 'ADM_PERSON.CADENA_JOBS_PERSCA';
BEGIN

	dbms_output.put_line( 'Inicia Borrado cadena de Jobs ' || gsbChainJobsPBMAFA );
	
	DBMS_SCHEDULER.DROP_CHAIN( gsbChainJobsPBMAFA, TRUE);
	
	COMMIT;
	
	dbms_output.put_line( 'Borrada cadena de Jobs ' || gsbChainJobsPBMAFA );
	
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/

        