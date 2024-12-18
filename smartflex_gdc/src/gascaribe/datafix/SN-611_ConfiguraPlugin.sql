column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
	nuExiste number;
BEGIN
	SELECT COUNT(1)
	INTO nuExiste
	FROM OPEN.LDC_PROCEDIMIENTO_OBJ
	WHERE TASK_TYPE_ID=12162
	  AND CAUSAL_ID=9944
	  AND PROCEDIMIENTO='LDC_PRFINALIZAPERIODOGRACIA';
	  
	IF nuExiste=0 THEN
		INSERT INTO LDC_PROCEDIMIENTO_OBJ(TASK_TYPE_ID,CAUSAL_ID,PROCEDIMIENTO,DESCRIPCION,ORDEN_EJEC,ACTIVO)
		VALUES(12162, 9944,'LDC_PRFINALIZAPERIODOGRACIA','CANCELA EL PERIODO DE GRACIA',1,'S');
		COMMIT;
		DBMS_OUTPUT.PUT_LINE('REGISTRO INSERTADO');
	ELSE
		DBMS_OUTPUT.PUT_LINE('REGISTRO EXISTE');
	END IF;
EXCEPTION
	WHEN OTHERS THEN
		ROLLBACK;
		DBMS_OUTPUT.PUT_LINE('ERROR: '||SQLERRM);
		
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/