PROMPT Crea Sinonimo a tabla GE_ITEMS para LDC_PR_CANTLEGAITEMS
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.GE_ITEMS FOR GE_ITEMS';
END;
/