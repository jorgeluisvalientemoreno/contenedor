PROMPT Crea Sinonimo LDCBI_PR_PRODUCT_REQUEST
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDCBI_PR_PRODUCT_REQUEST FOR LDCBI_PR_PRODUCT_REQUEST';
END;
/
