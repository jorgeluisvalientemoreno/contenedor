PROMPT Crea sinonimo objeto dependiente CUOTEXTR
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.CUOTEXTR FOR CUOTEXTR';
END;
/