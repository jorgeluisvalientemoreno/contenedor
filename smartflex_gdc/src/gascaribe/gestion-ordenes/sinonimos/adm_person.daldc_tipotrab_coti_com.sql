PROMPT Crea sinonimo objeto DALDC_TIPOTRAB_COTI_COM
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM DALDC_TIPOTRAB_COTI_COM FOR ADM_PERSON.DALDC_TIPOTRAB_COTI_COM';
END;
/