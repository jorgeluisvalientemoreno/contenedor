PROMPT Crea Sinonimo a DALDC_COTIZACION_CONSTRUCT
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM DALDC_COTIZACION_CONSTRUCT FOR ADM_PERSON.DALDC_COTIZACION_CONSTRUCT';
END;
/
