PROMPT Crea sinonimo objeto DALDC_ITEMS_POR_UNID_PRED
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM DALDC_ITEMS_POR_UNID_PRED FOR ADM_PERSON.DALDC_ITEMS_POR_UNID_PRED';
END;
/