PROMPT Crea sinonimo objeto DALD_CONSTRUCT_UNIT
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM DALD_CONSTRUCT_UNIT FOR ADM_PERSON.DALD_CONSTRUCT_UNIT';
END;
/
