PROMPT Crea sinonimo objeto DALDC_ACTBLOQ
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM DALDC_ACTBLOQ FOR ADM_PERSON.DALDC_ACTBLOQ';
END;
/