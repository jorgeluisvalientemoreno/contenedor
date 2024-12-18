PROMPT Crea Sinonimo a tabla ldc_ccxcateg
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.ldc_ccxcateg FOR ldc_ccxcateg';
END;
/