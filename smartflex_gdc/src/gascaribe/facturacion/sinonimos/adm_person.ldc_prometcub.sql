PROMPT Crea Sinonimo a tabla LDC_PROMETCUB
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_PROMETCUB FOR LDC_PROMETCUB';
END;
/