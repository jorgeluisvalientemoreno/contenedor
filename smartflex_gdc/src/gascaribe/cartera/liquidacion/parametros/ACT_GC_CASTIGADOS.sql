DECLARE
    nuContador  NUMBER;
BEGIN

    SELECT  COUNT(1) 
    INTO    nuContador
    FROM 	ld_parameter
    WHERE   parameter_id = 'ACT_GC_CASTIGADOS';
	
  IF (nuContador = 0) THEN
  
	INSERT INTO ld_parameter(parameter_id,
                            numeric_value,
                            value_chain,
                            description) 
            VALUES( 'ACT_GC_CASTIGADOS', 4000844, NULL, 'Almacenara la actividad del tipo de trabajo GESTION COBRO PREJURIDICO CASTIGADO');
				
    COMMIT;
  END IF;
END;
/