PROMPT Crea Sinonimo a tabla LDC_MARCA_PRODUCTO_LOG
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_MARCA_PRODUCTO_LOG FOR LDC_MARCA_PRODUCTO_LOG';
END;
/