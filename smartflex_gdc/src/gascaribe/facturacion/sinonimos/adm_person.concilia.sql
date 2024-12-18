PROMPT Crea Sinonimo a tabla concilia
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.concilia FOR concilia';
END;
/