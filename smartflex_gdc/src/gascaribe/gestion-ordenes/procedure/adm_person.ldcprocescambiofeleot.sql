DECLARE
  nuConta NUMBER;
BEGIN

	dbms_output.put_line('Inicia Eliminación del procedimiento LDCPROCESCAMBIOFELEOT');
	
	SELECT COUNT(*) INTO nuConta
	FROM dba_objects
	WHERE object_name = 'LDCPROCESCAMBIOFELEOT'
	AND OWNER = 'ADM_PERSON'
	AND OBJECT_TYPE = 'PROCEDURE';
   
	IF nuConta > 0 then
		EXECUTE IMMEDIATE 'DROP PROCEDURE ADM_PERSON.LDCPROCESCAMBIOFELEOT';
		dbms_output.put_line('Se elimina el procedimiento LDCPROCESCAMBIOFELEOT');
	ELSE
		dbms_output.put_line('El procedimiento LDCPROCESCAMBIOFELEOT no existe');
	END IF;  
  
	dbms_output.put_line('Finaliza Eliminación del procedimiento LDCPROCESCAMBIOFELEOT');
	
END;
/