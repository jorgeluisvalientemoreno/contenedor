PROMPT Crea Sinonimo a función LDC_FNUGETCATHIST
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM LDC_FNUGETCATHIST FOR ADM_PERSON.LDC_FNUGETCATHIST';
END;
/