PROMPT Crea Sinonimo a LDC_PRAJUSORDESINACTA
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM LDC_PRAJUSORDESINACTA FOR ADM_PERSON.LDC_PRAJUSORDESINACTA';
END;
/