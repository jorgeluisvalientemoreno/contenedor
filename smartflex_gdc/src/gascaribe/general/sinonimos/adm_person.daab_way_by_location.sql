PROMPT Crea sinonimo objeto dependiente DAAB_WAY_BY_LOCATION
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.DAAB_WAY_BY_LOCATION FOR DAAB_WAY_BY_LOCATION';
END;
/