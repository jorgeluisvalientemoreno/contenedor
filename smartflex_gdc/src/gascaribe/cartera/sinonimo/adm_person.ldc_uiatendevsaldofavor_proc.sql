PROMPT Crea Sinonimo a procedimiento LDC_UIATENDEVSALDOFAVOR_PROC
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM LDC_UIATENDEVSALDOFAVOR_PROC FOR ADM_PERSON.LDC_UIATENDEVSALDOFAVOR_PROC';
END;
/