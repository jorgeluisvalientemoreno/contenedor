PROMPT Crea sinonimo objeto dependiente LDC_SEQLCTARAN
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_SEQLCTARAN FOR LDC_SEQLCTARAN';
END;
/