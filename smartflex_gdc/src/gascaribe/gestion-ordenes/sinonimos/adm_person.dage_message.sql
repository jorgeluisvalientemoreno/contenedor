PROMPT Crea sinonimo objeto dependiente DAGE_MESSAGE
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.DAGE_MESSAGE FOR DAGE_MESSAGE';
END;
/
