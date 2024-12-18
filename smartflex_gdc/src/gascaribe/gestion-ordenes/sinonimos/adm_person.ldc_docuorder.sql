PROMPT Crea Sinonimo a tabla ldc_docuorder
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.ldc_docuorder FOR ldc_docuorder';
END;
/