DECLARE
    nuContador  NUMBER;
BEGIN

    SELECT  COUNT(1) 
    INTO    nuContador
    FROM 	ld_parameter
    WHERE   parameter_id = 'PAR_TIPOCAUSAL_CARDIF_DEF';
	
	IF (nuContador = 0) THEN
  
		INSERT INTO ld_parameter(parameter_id,
                            numeric_value,
                            value_chain,
                            description) 
            VALUES( 'PAR_TIPOCAUSAL_CARDIF_DEF', 2, NULL, 'TIPO DE CAUSAL CARDIF POR DEFECTO SI LA CAUSAL NO ESTA REGISTRADA EN LDC_TIPOCAUSALCARDIF');
				
		COMMIT;
	END IF;
END;
/