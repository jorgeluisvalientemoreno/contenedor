PROMPT Crea Sinonimo a tabla LDC_TEMP_SESUCARETA
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_TEMP_SESUCARETA FOR LDC_TEMP_SESUCARETA';
END;
/