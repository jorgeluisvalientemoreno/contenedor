DECLARE
	CURSOR cuSinonimo IS
		SELECT 	COUNT(1)
  		FROM 	dba_objects
  		WHERE 	object_name = 'FRCGETUNIDOPERTECCERT'
   		AND 	owner = 'OPEN'
   		AND 	object_type = 'SYNONYM';

  	nuConta NUMBER;
BEGIN

  	OPEN cuSinonimo;
	FETCH cuSinonimo INTO nuConta;
	CLOSE cuSinonimo;
   
  	IF nuConta > 0 then
        dbms_output.put_line('DROP SYNONYM OPEN.FRCGETUNIDOPERTECCERT');
    	EXECUTE IMMEDIATE 'DROP SYNONYM OPEN.FRCGETUNIDOPERTECCERT';
  	END IF;
END;
/