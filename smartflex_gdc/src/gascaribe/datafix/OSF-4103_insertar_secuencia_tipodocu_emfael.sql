DECLARE

    nuExiste NUMBER;
    
	cursor cuDatos(sbNombre VARCHAR2) is
	select count(1)
	  from SECUENCIA_TIPODOCU_EMFAEL
	 where nombre_secuencia = sbNombre;

BEGIN

   -- Agregar Columna Empresa

  	OPEN cuDatos('SEQ_FACTURA_ELECT_GEN_CONSFAEL');
	FETCH cuDatos INTO nuExiste;
	CLOSE cuDatos;

	IF nuExiste = 0 THEN
        INSERT INTO PERSONALIZACIONES.SECUENCIA_TIPODOCU_EMFAEL VALUES ('GDCA', 1,'SEQ_FACTURA_ELECT_GEN_CONSFAEL');
	END IF;

  	OPEN cuDatos('SEQ_FACTURA_ELECT_GEN_CONSVENT');
	FETCH cuDatos INTO nuExiste;
	CLOSE cuDatos;

	IF nuExiste = 0 THEN
        INSERT INTO PERSONALIZACIONES.SECUENCIA_TIPODOCU_EMFAEL VALUES ('GDCA', 2,'SEQ_FACTURA_ELECT_GEN_CONSVENT');
	END IF;

  	OPEN cuDatos('SEQ_FAC_ELEC_GEN_CONSFAEL_GDGU');
	FETCH cuDatos INTO nuExiste;
	CLOSE cuDatos;

	IF nuExiste = 0 THEN
        INSERT INTO PERSONALIZACIONES.SECUENCIA_TIPODOCU_EMFAEL VALUES ('GDGU', 1,'SEQ_FAC_ELEC_GEN_CONSFAEL_GDGU');
	END IF;

  	OPEN cuDatos('SEQ_FAC_ELEC_GEN_CONSVENT_GDGU');
	FETCH cuDatos INTO nuExiste;
	CLOSE cuDatos;

	IF nuExiste = 0 THEN
        INSERT INTO PERSONALIZACIONES.SECUENCIA_TIPODOCU_EMFAEL VALUES ('GDGU', 2,'SEQ_FAC_ELEC_GEN_CONSVENT_GDGU');
	END IF;

COMMIT;

END;
/