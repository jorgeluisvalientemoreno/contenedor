PROMPT Crea Sinonimo UT_CLOB
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.UT_CLOB FOR UT_CLOB';
END;
/