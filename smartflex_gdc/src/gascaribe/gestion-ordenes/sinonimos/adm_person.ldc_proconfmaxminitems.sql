PROMPT Crea Sinonimo LDC_PROCONFMAXMINITEMS
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM LDC_PROCONFMAXMINITEMS FOR ADM_PERSON.LDC_PROCONFMAXMINITEMS';
END;
/