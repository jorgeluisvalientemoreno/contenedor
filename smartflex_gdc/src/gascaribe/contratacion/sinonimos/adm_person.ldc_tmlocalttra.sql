PROMPT Crea Sinonimo a Tabla LDC_TMLOCALTTRA
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_TMLOCALTTRA FOR LDC_TMLOCALTTRA';
END;
/