PROMPT Crea Sinonimo a objeto DALDC_EQUIVA_LOCALIDAD
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.DALDC_EQUIVA_LOCALIDAD FOR DALDC_EQUIVA_LOCALIDAD';
END;
/