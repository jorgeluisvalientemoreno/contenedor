PROMPT Crea sinonimo objeto DALDC_AUDIT_CUOT_PROY
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM DALDC_AUDIT_CUOT_PROY FOR ADM_PERSON.DALDC_AUDIT_CUOT_PROY';
END;
/
