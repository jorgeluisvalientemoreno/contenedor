PROMPT Crea Sinonimo a Tabla GE_ITEMS_ATTRIBUTES
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.GE_ITEMS_ATTRIBUTES FOR  GE_ITEMS_ATTRIBUTES';
END;
/