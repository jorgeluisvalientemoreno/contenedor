PROMPT Crea Sinonimo a función FSBGETOBSNOLECT
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM FSBGETOBSNOLECT FOR ADM_PERSON.FSBGETOBSNOLECT';
END;
/