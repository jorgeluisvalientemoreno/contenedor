DECLARE
	CURSOR cuSinonimo IS
		SELECT 	COUNT(1)
  		FROM 	dba_objects
  		WHERE 	object_name = 'LDC_CONSULTACERTVIGTECFE'
   		AND 	owner = 'OPEN'
   		AND 	object_type = 'SYNONYM';

  	nuConta NUMBER;
BEGIN

  	OPEN cuSinonimo;
	FETCH cuSinonimo INTO nuConta;
	CLOSE cuSinonimo;
   
  	IF nuConta > 0 then
        dbms_output.put_line('DROP SYNONYM OPEN.LDC_CONSULTACERTVIGTECFE');
    	EXECUTE IMMEDIATE 'DROP SYNONYM OPEN.LDC_CONSULTACERTVIGTECFE';
  	END IF;
END;
/