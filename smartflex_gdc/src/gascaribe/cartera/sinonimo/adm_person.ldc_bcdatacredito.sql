PROMPT Crea Sinonimo LDC_BCDATACREDITO
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM LDC_BCDATACREDITO FOR ADM_PERSON.LDC_BCDATACREDITO';
END;
/