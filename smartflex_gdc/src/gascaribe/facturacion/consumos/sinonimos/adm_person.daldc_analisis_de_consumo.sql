PROMPT Crea sinonimo objeto DALDC_ANALISIS_DE_CONSUMO
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM DALDC_ANALISIS_DE_CONSUMO FOR ADM_PERSON.DALDC_ANALISIS_DE_CONSUMO';
END;
/
