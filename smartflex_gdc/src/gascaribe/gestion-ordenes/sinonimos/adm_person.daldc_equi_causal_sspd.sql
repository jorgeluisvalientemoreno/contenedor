PROMPT Crea sinonimo objeto DALDC_EQUI_CAUSAL_SSPD
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM DALDC_EQUI_CAUSAL_SSPD FOR ADM_PERSON.DALDC_EQUI_CAUSAL_SSPD';
END;
/