PROMPT Crea Sinonimo a LDC_BCDELETECHARGES
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM LDC_BCDELETECHARGES FOR ADM_PERSON.LDC_BCDELETECHARGES';
END;
/