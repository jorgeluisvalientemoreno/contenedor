SET SERVEROUTPUT ON;
COLUMN dt NEW_VALUE vdt
COLUMN db NEW_VALUE vdb
SELECT to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db FROM dual;
SET SERVEROUTPUT ON SIZE UNLIMITED 
SELECT to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio FROM dual;

DECLARE
	 nuConta  NUMBER;
 
	CURSOR cuExiste(isbObjeto IN VARCHAR2) IS
		SELECT 	COUNT(1)
		FROM 	homologacion_servicios
		WHERE 	servicio_origen = isbObjeto;
BEGIN
    dbms_output.put_line('Actualizar registros en homologacion_servicios');

	DELETE FROM homologacion_servicios WHERE servicio_destino = 'PKG_BOPERSONAL.FSBGETUSUARIO';
    
    OPEN cuExiste('DAGE_PERSON.FNUGETUSER_ID'); 
	FETCH cuExiste INTO nuConta; 
	CLOSE cuExiste; 
	
	IF nuConta = 0 THEN	
		INSERT INTO homologacion_servicios 
		VALUES 
			(
				'OPEN', 
				'DAGE_PERSON.FNUGETUSER_ID',
				'Obtiene id del usuario de la persona',
				'ADM_PERSON',
				'PKG_BCPERSONAL.FNUOBTIENEUSUARIO',
				'Obtiene id del usuario de la persona',
				''
			);
	END IF;
	
	OPEN cuExiste('GE_BCPERSON.FNUGETFIRSTPERSONBYUSERID'); 
	FETCH cuExiste INTO nuConta; 
	CLOSE cuExiste; 
	
	IF nuConta = 0 THEN 
		insert into homologacion_servicios 
		values
			( 
				'OPEN',
				'GE_BCPERSON.FNUGETFIRSTPERSONBYUSERID',
				'Retorna la persona configurada para el usuario conectado',
				'ADM_PERSON',
				'PKG_BOPERSONAL.FNUOBTPERSONAPORUSUARIO',
				'Retorna la persona configurada para el usuario conectado',
				''
			); 
	END IF;
	
	OPEN cuExiste('DAGE_PERSON.FSBGETNAME_'); 
	FETCH cuExiste INTO nuConta; 
	CLOSE cuExiste; 
	IF nuConta = 0 THEN 
		insert into homologacion_servicios 
		values
			( 
				'OPEN',
				'DAGE_PERSON.FSBGETNAME_',
				'Retorna el nombre en ge_person',
				'ADM_PERSON',
				'PKG_BCPERSONAL.FSBOBTNOMBREPORUSUARIO',
				'Retorna el nombre de ge_person',
				''
			); 
	END IF;

    COMMIT;
	
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('No se pudo actualizar registro en homologacion_servicios, '||sqlerrm);
END;
/
SELECT to_char(sysdate, 'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin
  FROM dual;
/