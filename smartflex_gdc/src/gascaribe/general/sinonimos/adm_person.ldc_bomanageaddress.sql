PROMPT Crea sinonimo objeto LDC_BOMANAGEADDRESS
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM LDC_BOMANAGEADDRESS FOR ADM_PERSON.LDC_BOMANAGEADDRESS';
END;
/