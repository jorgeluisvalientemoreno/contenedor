PROMPT Crea Sinonimo a LDC_PKGESTIONABONDECONS
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM LDC_PKGESTIONABONDECONS FOR ADM_PERSON.LDC_PKGESTIONABONDECONS';
END;
/