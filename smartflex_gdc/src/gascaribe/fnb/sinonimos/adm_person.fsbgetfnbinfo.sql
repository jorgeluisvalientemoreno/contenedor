PROMPT Crea Sinonimo a función FSBGETFNBINFO
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM FSBGETFNBINFO FOR ADM_PERSON.FSBGETFNBINFO';
END;
/