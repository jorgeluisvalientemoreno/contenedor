DECLARE
    nuContador  NUMBER;
BEGIN

    SELECT  COUNT(1) 
    INTO    nuContador
    FROM 	ge_message
    WHERE   message_id = -20101;
	
	IF (nuContador = 0) THEN
  
		INSERT INTO ge_message
            VALUES(-20101, '%s1', 'E', 13, 'Error controlado', null, 1, 'Y');
				
		COMMIT;
	END IF;
END;
/