PROMPT Crea sinonimo objeto dependiente LDC_FNB_SUBS_BLOCK
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_FNB_SUBS_BLOCK FOR LDC_FNB_SUBS_BLOCK';
END;
/