PROMPT Crea sinonimo objeto dependiente LDC_PKG_OR_ITEM
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_PKG_OR_ITEM FOR LDC_PKG_OR_ITEM';
END;
/