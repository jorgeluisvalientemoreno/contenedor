PROMPT Crea Sinonimo a procedimiento LDC_PRVALIDALECTURASUSP
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM LDC_PRVALIDALECTURASUSP FOR ADM_PERSON.LDC_PRVALIDALECTURASUSP';
END;
/