PROMPT Crea sinonimo objeto dependiente LDC_LOGPRESCONT
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_LOGPRESCONT FOR LDC_LOGPRESCONT';
END;
/