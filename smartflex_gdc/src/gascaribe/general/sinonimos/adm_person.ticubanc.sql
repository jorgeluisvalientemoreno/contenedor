PROMPT Crea sinonimo objeto dependiente TICUBANC
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.TICUBANC FOR TICUBANC';
END;
/
