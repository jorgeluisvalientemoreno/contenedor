PROMPT Crea Sinonimo LDC_TARIFAS_GESTCART
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_TARIFAS_GESTCART FOR LDC_TARIFAS_GESTCART';
END;
/