PROMPT Crea sinonimo objeto DALD_SUBSIDY_CONCEPT
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM DALD_SUBSIDY_CONCEPT FOR ADM_PERSON.DALD_SUBSIDY_CONCEPT';
END;
/