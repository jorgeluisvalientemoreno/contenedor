PROMPT Crea Sinonimo a tabla LDC_IMCOELLO
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_IMCOELLO FOR LDC_IMCOELLO';
END;
/