PROMPT Crea sinonimo objeto dependiente LDC_SUSP_PERSECUCION
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_SUSP_PERSECUCION FOR LDC_SUSP_PERSECUCION';
END;
/