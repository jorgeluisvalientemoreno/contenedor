PROMPT Crea Sinonimo LDC_TIPOCON_ADMINISTRATIVO
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_TIPOCON_ADMINISTRATIVO FOR LDC_TIPOCON_ADMINISTRATIVO';
END;
/