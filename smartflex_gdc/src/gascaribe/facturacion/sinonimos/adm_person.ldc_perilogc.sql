PROMPT Crea sinonimo objeto dependiente LDC_PERILOGC
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_PERILOGC FOR LDC_PERILOGC';
END;
/
