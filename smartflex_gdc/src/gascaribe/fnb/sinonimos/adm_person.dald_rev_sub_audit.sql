PROMPT Crea sinonimo objeto DALD_REV_SUB_AUDIT
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM DALD_REV_SUB_AUDIT FOR ADM_PERSON.DALD_REV_SUB_AUDIT';
END;
/
