PROMPT Crea Sinonimo a Paquete UT_MAILPOST
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.UT_MAILPOST FOR UT_MAILPOST';
END;
/