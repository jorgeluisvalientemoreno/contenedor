DECLARE
	CURSOR cuSinonimo IS
		SELECT 	COUNT(1)
  		FROM 	dba_objects
  		WHERE 	object_name = 'LDC_ATENTESOLOTFINREVPER'
   		AND 	owner = 'ADM_PERSON'
   		AND 	object_type = 'SYNONYM';

  	nuConta NUMBER;
BEGIN

  	OPEN cuSinonimo;
	FETCH cuSinonimo INTO nuConta;
	CLOSE cuSinonimo;
   
  	IF nuConta > 0 then
        dbms_output.put_line('DROP SYNONYM ADM_PERSON.LDC_ATENTESOLOTFINREVPER');
    	EXECUTE IMMEDIATE 'DROP SYNONYM ADM_PERSON.LDC_ATENTESOLOTFINREVPER';
  	END IF;
END;
/