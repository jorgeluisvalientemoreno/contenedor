PROMPT Crea sinonimo objeto dependiente LDC_USSFMLE
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_USSFMLE FOR LDC_USSFMLE';
END;
/
