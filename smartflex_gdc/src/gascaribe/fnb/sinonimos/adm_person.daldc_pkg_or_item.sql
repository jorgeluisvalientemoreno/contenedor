PROMPT Crea sinonimo objeto DALDC_PKG_OR_ITEM
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM DALDC_PKG_OR_ITEM FOR ADM_PERSON.DALDC_PKG_OR_ITEM';
END;
/