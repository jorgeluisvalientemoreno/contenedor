DECLARE
    nuContador  NUMBER;
BEGIN

    SELECT  COUNT(1) 
    INTO    nuContador
    FROM 	ldc_pararepe
    WHERE   parecodi = 'LDC_MINJOB';
	
	IF (nuContador = 0) THEN
  
		INSERT INTO ldc_pararepe(parecodi, parevanu, paravast, paradesc)
        VALUES( 'LDC_MINJOB', 2, NULL, 'Minutos de espera para ejecutar el job LDC_PKGESTIOSUSPADMYVOLU.PREJECPROCCTS - Tramite Reconexion Voluntaria');

		COMMIT;
	END IF;
END;
/