PROMPT Crea sinonimo objeto dependiente GE_ITEMS_ESTADO_INV
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.GE_ITEMS_ESTADO_INV FOR GE_ITEMS_ESTADO_INV';
END;
/
