PROMPT Crea Sinonimo a tabla au_bosystem
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.au_bosystem FOR au_bosystem';
END;
/