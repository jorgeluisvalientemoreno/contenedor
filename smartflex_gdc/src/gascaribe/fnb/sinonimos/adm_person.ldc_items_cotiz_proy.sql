PROMPT Crea sinonimo objeto dependiente LDC_ITEMS_COTIZ_PROY
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_ITEMS_COTIZ_PROY FOR LDC_ITEMS_COTIZ_PROY';
END;
/
