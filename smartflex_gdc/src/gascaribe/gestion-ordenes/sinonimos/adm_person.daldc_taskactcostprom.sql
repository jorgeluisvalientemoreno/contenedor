PROMPT Crea sinonimo objeto DALDC_TASKACTCOSTPROM
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM DALDC_TASKACTCOSTPROM FOR ADM_PERSON.DALDC_TASKACTCOSTPROM';
END;
/
