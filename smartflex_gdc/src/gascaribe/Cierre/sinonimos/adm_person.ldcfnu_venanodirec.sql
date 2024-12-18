DECLARE
	CURSOR cuSinonimo IS
		SELECT 	COUNT(1)
  		FROM 	dba_objects
  		WHERE 	object_name = 'LDCFNU_VENANODIREC'
   		AND 	owner = 'OPEN'
   		AND 	object_type = 'SYNONYM';

  	nuConta NUMBER;
BEGIN

  	OPEN cuSinonimo;
	FETCH cuSinonimo INTO nuConta;
	CLOSE cuSinonimo;
   
  	IF nuConta > 0 then
        dbms_output.put_line('DROP SYNONYM OPEN.LDCFNU_VENANODIREC');
    	EXECUTE IMMEDIATE 'DROP SYNONYM OPEN.LDCFNU_VENANODIREC';
  	END IF;
END;
/