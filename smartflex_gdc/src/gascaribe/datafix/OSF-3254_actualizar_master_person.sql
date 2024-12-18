column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

BEGIN

    UPDATE 	personalizaciones.master_personalizaciones
	SET		comentario = 'OPEN'
	WHERE 	comentario like '%DEJAR EN OPEN%';
	
	UPDATE 	personalizaciones.master_personalizaciones
	SET		comentario = 'MIGRADO ADM_PERSON'
	WHERE 	comentario like 'ADM_PERSON%';
	
	UPDATE 	personalizaciones.master_personalizaciones
	SET		comentario = 'BORRADO'
	WHERE 	nombre = 'FNUGETORDERFINISHED';
	
	UPDATE 	personalizaciones.master_personalizaciones
	SET		comentario = 'MIGRADO ADM_PERSON'
	WHERE 	nombre = 'LDC_RENEWPOLICIESBYCOLLECTIVE';
	
	UPDATE 	personalizaciones.master_personalizaciones
	SET		comentario = 'BORRADO - '||comentario
	WHERE 	nombre IN ('LDC_EXOGENA','LDUSPR','PBPGC','PBACUCARTOTK','PROCQUITAESPACIOSOSF','PR_AB_ADDRESS_T','PR_DIRECCIONES_N','PR_AB_ADDRESS_N','DIRECCIONES_N','PR_AB_ADDRESS','MASTERDIRECCIONES');
	
	UPDATE 	personalizaciones.master_personalizaciones
	SET		comentario = 'OPEN'
	WHERE 	nombre IN ('LDC_ENCUESTA','LDCPALICANOTCREDCOMPEN','LDCPROCREVERSAMARCACAUSFALL','LDC_VALIDA_DATO_ADI_CERTIF','PROINFOADICIONALCONTRATO','PRASIGNARCPLANO','PROCLDCACTCERT');
    
    UPDATE 	personalizaciones.master_personalizaciones
	SET		tipo_objeto = 'TABLE'
	WHERE 	tipo_objeto = 'TABLA';
	
	COMMIT;

END;
/
DECLARE
	CURSOR cuSinonimo IS
		SELECT 	COUNT(1)
  		FROM 	dba_objects
  		WHERE 	object_name = 'PROCCONSESTADOSCUENTACONTRATOS'
   		AND 	owner = 'PUBLIC'
   		AND 	object_type = 'SYNONYM';

  	nuConta NUMBER;
BEGIN

  	OPEN cuSinonimo;
	FETCH cuSinonimo INTO nuConta;
	CLOSE cuSinonimo;
   
  	IF nuConta > 0 then
        dbms_output.put_line('DROP PUBLIC SYNONYM PROCCONSESTADOSCUENTACONTRATOS');
    	EXECUTE IMMEDIATE 'DROP PUBLIC SYNONYM PROCCONSESTADOSCUENTACONTRATOS';
  	END IF;
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/