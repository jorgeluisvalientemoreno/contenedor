PROMPT Crea Sinonimo a tabla LDC_CMMITEMSXTT para LDC_PR_CANTLEGAITEMS
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_CMMITEMSXTT FOR LDC_CMMITEMSXTT';
END;
/