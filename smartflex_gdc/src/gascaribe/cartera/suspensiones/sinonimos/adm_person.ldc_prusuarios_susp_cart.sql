PROMPT Crea Sinonimo a procedimiento LDC_PRUSUARIOS_SUSP_CART
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM LDC_PRUSUARIOS_SUSP_CART FOR ADM_PERSON.LDC_PRUSUARIOS_SUSP_CART';
END;
/