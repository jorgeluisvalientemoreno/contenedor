PROMPT Crea Sinonimo a Procedimiento LDC_PR_CANTLEGAITEMS
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM LDC_PR_CANTLEGAITEMS FOR ADM_PERSON.LDC_PR_CANTLEGAITEMS';
END;
/