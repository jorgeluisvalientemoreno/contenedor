PROMPT Crea Sinonimo a procedimiento LDC_SUSPPORRPUSUVENC
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM LDC_SUSPPORRPUSUVENC FOR ADM_PERSON.LDC_SUSPPORRPUSUVENC';
END;
/