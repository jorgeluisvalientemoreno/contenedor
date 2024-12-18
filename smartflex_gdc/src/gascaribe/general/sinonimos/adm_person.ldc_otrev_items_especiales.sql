PROMPT Crea sinonimo objeto dependiente ldc_otrev_items_especiales
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.ldc_otrev_items_especiales FOR ldc_otrev_items_especiales';
END;
/
