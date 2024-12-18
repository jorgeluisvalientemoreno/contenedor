DECLARE
	CURSOR cuSinonimo IS
		SELECT 	COUNT(1)
  		FROM 	dba_objects
  		WHERE 	object_name = 'LDC_RETORNAINTMOFI'
   		AND 	owner = 'OPEN'
   		AND 	object_type = 'SYNONYM';

  	nuConta NUMBER;
BEGIN

  	OPEN cuSinonimo;
	FETCH cuSinonimo INTO nuConta;
	CLOSE cuSinonimo;
   
  	IF nuConta > 0 then
        dbms_output.put_line('DROP SYNONYM OPEN.LDC_RETORNAINTMOFI');
    	EXECUTE IMMEDIATE 'DROP SYNONYM OPEN.LDC_RETORNAINTMOFI';
  	END IF;
END;
/