PROMPT Crea sinonimo objeto dependiente LDC_MARCAPRODREPA
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_MARCAPRODREPA FOR LDC_MARCAPRODREPA';
END;
/