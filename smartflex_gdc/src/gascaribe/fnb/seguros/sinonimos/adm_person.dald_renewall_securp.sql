PROMPT Crea sinonimo objeto DALD_RENEWALL_SECURP
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM DALD_RENEWALL_SECURP FOR ADM_PERSON.DALD_RENEWALL_SECURP';
END;
/
