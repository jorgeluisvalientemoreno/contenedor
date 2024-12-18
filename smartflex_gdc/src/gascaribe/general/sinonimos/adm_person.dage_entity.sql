PROMPT Crea sinonimo objeto dependiente dage_entity
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.dage_entity FOR dage_entity';
END;
/
