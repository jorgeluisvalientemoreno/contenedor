PROMPT Crea Sinonimo a función LDC_FNUGETULTIMOBLOQUEO
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM LDC_FNUGETULTIMOBLOQUEO FOR ADM_PERSON.LDC_FNUGETULTIMOBLOQUEO';
END;
/