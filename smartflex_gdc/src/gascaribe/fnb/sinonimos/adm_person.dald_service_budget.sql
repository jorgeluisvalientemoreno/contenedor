PROMPT Crea sinonimo objeto DALD_SERVICE_BUDGET
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM DALD_SERVICE_BUDGET FOR ADM_PERSON.DALD_SERVICE_BUDGET';
END;
/
