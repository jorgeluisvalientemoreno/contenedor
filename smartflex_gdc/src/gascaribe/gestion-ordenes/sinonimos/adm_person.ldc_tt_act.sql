PROMPT Crea Sinonimo a tabla LDC_TT_ACT
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_TT_ACT FOR LDC_TT_ACT';
END;
/