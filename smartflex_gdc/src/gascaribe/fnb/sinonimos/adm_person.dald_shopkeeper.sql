PROMPT Crea sinonimo objeto DALD_SHOPKEEPER
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM DALD_SHOPKEEPER FOR ADM_PERSON.DALD_SHOPKEEPER';
END;
/
