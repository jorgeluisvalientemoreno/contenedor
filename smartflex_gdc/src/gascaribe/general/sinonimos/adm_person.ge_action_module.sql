PROMPT Crea sinonimo objeto dependiente GE_ACTION_MODULE
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.GE_ACTION_MODULE FOR GE_ACTION_MODULE';
END;
/
