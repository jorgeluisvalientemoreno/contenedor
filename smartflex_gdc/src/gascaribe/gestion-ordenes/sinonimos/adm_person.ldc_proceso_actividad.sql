PROMPT Crea Sinonimo LDC_PROCESO_ACTIVIDAD
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_PROCESO_ACTIVIDAD FOR LDC_PROCESO_ACTIVIDAD';
END;
/