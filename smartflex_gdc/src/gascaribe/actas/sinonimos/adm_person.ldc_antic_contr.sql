PROMPT Crea sinonimo objeto dependiente LDC_ANTIC_CONTR
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_ANTIC_CONTR FOR LDC_ANTIC_CONTR';
END;
/