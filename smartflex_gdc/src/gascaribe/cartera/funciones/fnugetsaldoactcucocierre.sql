DECLARE
	nuExiste NUMBER;
	
	CURSOR cuExiste IS
		SELECT 	COUNT(1)
		FROM 	dba_objects
		WHERE 	object_name = 'FNUGETSALDOACTCUCOCIERRE'
		AND 	owner = 'OPEN'
		AND 	object_type = 'FUNCTION';
BEGIN
	
	OPEN cuExiste;
	FETCH cuExiste INTO nuExiste;
	CLOSE cuExiste;
	

	IF (nuExiste > 0) THEN
		EXECUTE IMMEDIATE 'DROP FUNCTION OPEN.FNUGETSALDOACTCUCOCIERRE';
	END IF;
END;
/