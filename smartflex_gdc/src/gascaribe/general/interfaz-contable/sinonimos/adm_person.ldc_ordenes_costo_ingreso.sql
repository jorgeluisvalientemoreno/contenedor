PROMPT Crea Sinonimo LDC_ORDENES_COSTO_INGRESO
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_ORDENES_COSTO_INGRESO FOR LDC_ORDENES_COSTO_INGRESO';
END;
/
