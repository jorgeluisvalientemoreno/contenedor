PROMPT Crea sinonimo objeto DALD_CONVENT_EXITO
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM DALD_CONVENT_EXITO FOR ADM_PERSON.DALD_CONVENT_EXITO';
END;
/