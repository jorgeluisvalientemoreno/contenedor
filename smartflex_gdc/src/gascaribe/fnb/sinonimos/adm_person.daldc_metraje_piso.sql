PROMPT Crea sinonimo objeto DALDC_METRAJE_PISO
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM DALDC_METRAJE_PISO FOR ADM_PERSON.DALDC_METRAJE_PISO';
END;
/
