PROMPT Crea sinonimo objeto dependiente BANCO
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.BANCO FOR BANCO';
END;
/