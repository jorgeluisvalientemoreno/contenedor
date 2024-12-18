PROMPT Crea Sinonimo a tabla ldc_prod_comerc_sector
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.ldc_prod_comerc_sector FOR ldc_prod_comerc_sector';
END;
/