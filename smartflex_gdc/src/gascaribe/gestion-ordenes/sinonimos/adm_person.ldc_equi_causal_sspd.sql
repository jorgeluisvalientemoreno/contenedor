PROMPT Crea sinonimo objeto dependiente LDC_EQUI_CAUSAL_SSPD
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_EQUI_CAUSAL_SSPD FOR LDC_EQUI_CAUSAL_SSPD';
END;
/