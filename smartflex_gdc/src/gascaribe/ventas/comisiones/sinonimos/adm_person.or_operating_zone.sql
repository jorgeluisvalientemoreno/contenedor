PROMPT Crea sinonimo objeto dependiente OR_OPERATING_ZONE
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.OR_OPERATING_ZONE FOR OR_OPERATING_ZONE';
END;
/
