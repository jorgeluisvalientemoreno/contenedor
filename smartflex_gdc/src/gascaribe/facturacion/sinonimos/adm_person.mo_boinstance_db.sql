PROMPT Crea sinonimo objeto dependiente MO_BOINSTANCE_DB
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.MO_BOINSTANCE_DB FOR MO_BOINSTANCE_DB';
END;
/