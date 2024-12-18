PROMPT Crea Sinonimo a tabla ldc_pgeneratebillprep
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.ldc_pgeneratebillprep FOR ldc_pgeneratebillprep';
END;
/