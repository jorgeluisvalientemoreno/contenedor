PROMPT Crea sinonimo objeto dependiente LDC_PKG_OR_ITEM_DETAIL
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_PKG_OR_ITEM_DETAIL FOR LDC_PKG_OR_ITEM_DETAIL';
END;
/