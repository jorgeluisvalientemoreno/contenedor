PROMPT Crea sinonimo objeto dependiente OR_BORELATEDORDER
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.OR_BORELATEDORDER FOR OR_BORELATEDORDER';
END;
/