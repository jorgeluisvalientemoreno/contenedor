PROMPT Crea Sinonimo a función FSBGETTIPOCONS
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM FSBGETTIPOCONS FOR ADM_PERSON.FSBGETTIPOCONS';
END;
/