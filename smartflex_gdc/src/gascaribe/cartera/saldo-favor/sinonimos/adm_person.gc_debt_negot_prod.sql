PROMPT Crea sinonimo objeto dependiente GC_DEBT_NEGOT_PROD
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.GC_DEBT_NEGOT_PROD FOR GC_DEBT_NEGOT_PROD';
END;
/