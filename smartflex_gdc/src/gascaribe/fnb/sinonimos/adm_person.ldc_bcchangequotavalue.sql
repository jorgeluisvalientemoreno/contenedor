PROMPT Crea Sinonimo a LDC_BCCHANGEQUOTAVALUE
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM LDC_BCCHANGEQUOTAVALUE FOR ADM_PERSON.LDC_BCCHANGEQUOTAVALUE';
END;
/