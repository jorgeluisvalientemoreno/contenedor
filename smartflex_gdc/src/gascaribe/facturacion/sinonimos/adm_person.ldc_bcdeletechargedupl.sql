PROMPT Crea Sinonimo a LDC_BCDELETECHARGEDUPL
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM LDC_BCDELETECHARGEDUPL FOR ADM_PERSON.LDC_BCDELETECHARGEDUPL';
END;
/