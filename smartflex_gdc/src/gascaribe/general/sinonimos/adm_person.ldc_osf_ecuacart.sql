PROMPT Crea Sinonimo a Tabla LDC_OSF_ECUACART
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_OSF_ECUACART FOR LDC_OSF_ECUACART';
END;
/