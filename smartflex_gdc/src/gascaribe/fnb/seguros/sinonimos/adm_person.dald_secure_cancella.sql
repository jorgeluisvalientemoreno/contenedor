PROMPT Crea sinonimo objeto DALD_SECURE_CANCELLA
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM DALD_SECURE_CANCELLA FOR ADM_PERSON.DALD_SECURE_CANCELLA';
END;
/
