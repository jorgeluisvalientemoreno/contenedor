PROMPT Crea Sinonimo a tabla ldc_itemcous
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.ldc_itemcous FOR ldc_itemcous';
END;
/