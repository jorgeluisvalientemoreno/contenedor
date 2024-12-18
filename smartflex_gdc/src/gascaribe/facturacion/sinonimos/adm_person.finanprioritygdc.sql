DECLARE
	CURSOR cuSinonimo IS
		SELECT 	COUNT(1)
  		FROM 	dba_objects
  		WHERE 	object_name = 'FINANPRIORITYGDC'
   		AND 	owner = 'ADM_PERSON'
   		AND 	object_type = 'SYNONYM';

  	nuConta NUMBER;
BEGIN

  	OPEN cuSinonimo;
	FETCH cuSinonimo INTO nuConta;
	CLOSE cuSinonimo;
   
  	IF nuConta > 0 then
        dbms_output.put_line('DROP SYNONYM ADM_PERSON.FINANPRIORITYGDC');
    	EXECUTE IMMEDIATE 'DROP SYNONYM ADM_PERSON.FINANPRIORITYGDC';
  	END IF;
END;
/