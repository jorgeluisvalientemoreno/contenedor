PROMPT Crea sinonimo objeto dependiente MOVIDIFE
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.MOVIDIFE FOR MOVIDIFE';
END;
/