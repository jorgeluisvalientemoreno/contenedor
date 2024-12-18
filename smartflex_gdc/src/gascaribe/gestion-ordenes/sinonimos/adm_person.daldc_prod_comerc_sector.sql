PROMPT Crea Sinonimo a tabla daldc_prod_comerc_sector
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.daldc_prod_comerc_sector FOR daldc_prod_comerc_sector';
END;
/