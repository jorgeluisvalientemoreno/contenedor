PROMPT Crea Sinonimo a DALDC_ESTACION_REGULA
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM DALDC_ESTACION_REGULA FOR ADM_PERSON.DALDC_ESTACION_REGULA';
END;
/