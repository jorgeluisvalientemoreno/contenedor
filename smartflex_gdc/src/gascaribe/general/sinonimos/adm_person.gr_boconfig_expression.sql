PROMPT Crea sinonimo objeto dependiente GR_BOCONFIG_EXPRESSION
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.GR_BOCONFIG_EXPRESSION FOR GR_BOCONFIG_EXPRESSION';
END;
/
