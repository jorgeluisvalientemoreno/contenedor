PROMPT Crea Sinonimo a tabla ldc_reclamos
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.ldc_reclamos FOR ldc_reclamos';
END;
/