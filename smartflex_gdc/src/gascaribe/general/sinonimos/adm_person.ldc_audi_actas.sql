PROMPT Crea Sinonimo LDC_AUDI_ACTAS
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_AUDI_ACTAS FOR LDC_AUDI_ACTAS';
END;
/