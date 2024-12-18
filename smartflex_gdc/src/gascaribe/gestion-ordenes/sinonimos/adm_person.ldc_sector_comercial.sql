PROMPT Crea Sinonimo a tabla ldc_sector_comercial
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.ldc_sector_comercial FOR ldc_sector_comercial';
END;
/