PROMPT Crea sinonimo objeto dependiente PROCREST
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.PROCREST FOR PROCREST';
END;
/
