PROMPT Crea Sinonimo a Procedimiento LDC_VALIDA_ORASAR
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM LDC_VALIDA_ORASAR FOR ADM_PERSON.LDC_VALIDA_ORASAR';
END;
/