PROMPT Crea Sinonimo LDCBI_PRODUCTO_TRG
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDCBI_PRODUCTO_TRG FOR LDCBI_PRODUCTO_TRG';
END;
/
