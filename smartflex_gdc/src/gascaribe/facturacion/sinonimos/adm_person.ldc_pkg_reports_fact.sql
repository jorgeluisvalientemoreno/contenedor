PROMPT Crea Sinonimo a LDC_PKG_REPORTS_FACT
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM LDC_PKG_REPORTS_FACT FOR ADM_PERSON.LDC_PKG_REPORTS_FACT';
END;
/