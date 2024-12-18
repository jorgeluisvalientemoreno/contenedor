DECLARE
    nuContador  NUMBER;
BEGIN

    SELECT  COUNT(1) 
    INTO    nuContador
    FROM 	ld_parameter
    WHERE   parameter_id = 'TT_GC_CARTERA';
	
  IF (nuContador = 0) THEN
  
	INSERT INTO ld_parameter(parameter_id,
                            numeric_value,
                            value_chain,
                            description) 
            VALUES('TT_GC_CARTERA', NULL, '5005,', 'Almacenara los tipos de trabajo que aplican para Gestion de Cobro Prejuridico');
				
    COMMIT;
  END IF;
END;
/