PROMPT Crea sinonimo objeto DALD_SUB_REMAIN_DELIV
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM DALD_SUB_REMAIN_DELIV FOR ADM_PERSON.DALD_SUB_REMAIN_DELIV';
END;
/
