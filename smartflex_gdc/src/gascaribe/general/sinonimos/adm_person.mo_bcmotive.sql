PROMPT Crea sinonimo objeto dependiente MO_BCMOTIVE
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.MO_BCMOTIVE FOR MO_BCMOTIVE';
END;
/