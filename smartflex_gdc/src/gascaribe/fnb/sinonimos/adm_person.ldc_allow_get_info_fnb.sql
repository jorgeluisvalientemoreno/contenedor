PROMPT Crea Sinonimo a función LDC_ALLOW_GET_INFO_FNB
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM LDC_ALLOW_GET_INFO_FNB FOR ADM_PERSON.LDC_ALLOW_GET_INFO_FNB';
END;
/
