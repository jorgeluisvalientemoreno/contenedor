PROMPT Crea Sinonimo a tabla PROD_NEGDEUDA_RP para LDCCREATETRAMITERECONEXIONXML
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.PROD_NEGDEUDA_RP FOR PROD_NEGDEUDA_RP';
END;
/