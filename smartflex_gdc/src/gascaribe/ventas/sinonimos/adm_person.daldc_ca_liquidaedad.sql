PROMPT Crea Sinonimo a DALDC_CA_LIQUIDAEDAD
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM DALDC_CA_LIQUIDAEDAD FOR ADM_PERSON.DALDC_CA_LIQUIDAEDAD';
END;
/