DECLARE
	CURSOR cuSinonimo IS
		SELECT 	COUNT(1)
  		FROM 	dba_objects
  		WHERE 	object_name = 'LDCFNCRETORNAMESLIQ'
   		AND 	owner = 'OPEN'
   		AND 	object_type = 'SYNONYM';

  	nuConta NUMBER;
BEGIN

  	OPEN cuSinonimo;
	FETCH cuSinonimo INTO nuConta;
	CLOSE cuSinonimo;
   
  	IF nuConta > 0 then
        dbms_output.put_line('DROP SYNONYM OPEN.LDCFNCRETORNAMESLIQ');
    	EXECUTE IMMEDIATE 'DROP SYNONYM OPEN.LDCFNCRETORNAMESLIQ';
  	END IF;
END;
/