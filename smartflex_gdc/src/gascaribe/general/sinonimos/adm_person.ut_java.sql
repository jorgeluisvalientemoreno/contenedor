PROMPT Crea sinonimo objeto dependiente UT_JAVA
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.UT_JAVA FOR UT_JAVA';
END;
/