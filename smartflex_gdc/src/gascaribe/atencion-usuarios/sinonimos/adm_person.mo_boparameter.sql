PROMPT Crea sinonimo objeto dependiente MO_BOPARAMETER
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.MO_BOPARAMETER FOR MO_BOPARAMETER';
END;
/
