PROMPT Crea sinonimo objeto dependiente LDC_INFOGESMOV_LOG
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_INFOGESMOV_LOG FOR LDC_INFOGESMOV_LOG';
END;
/