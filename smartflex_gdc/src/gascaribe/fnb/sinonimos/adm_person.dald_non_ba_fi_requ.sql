PROMPT Crea sinonimo objeto DALD_NON_BA_FI_REQU
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM DALD_NON_BA_FI_REQU FOR ADM_PERSON.DALD_NON_BA_FI_REQU';
END;
/