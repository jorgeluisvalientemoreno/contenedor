PROMPT Crea sinonimo objeto DALD_SAMPLE_CONT
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM DALD_SAMPLE_CONT FOR ADM_PERSON.DALD_SAMPLE_CONT';
END;
/
