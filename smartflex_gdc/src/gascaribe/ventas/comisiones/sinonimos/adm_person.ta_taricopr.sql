PROMPT Crea sinonimo objeto dependiente TA_TARICOPR
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.TA_TARICOPR FOR TA_TARICOPR';
END;
/
