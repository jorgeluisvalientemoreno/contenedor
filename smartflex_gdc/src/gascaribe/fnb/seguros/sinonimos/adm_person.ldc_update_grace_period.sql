PROMPT Crea sinonimo objeto dependiente LDC_UPDATE_GRACE_PERIOD
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM LDC_UPDATE_GRACE_PERIOD FOR ADM_PERSON.LDC_UPDATE_GRACE_PERIOD';
END;
/