PROMPT Crea sinonimo objeto LDC_AB_BOADDRESSCHANGE
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM LDC_AB_BOADDRESSCHANGE FOR ADM_PERSON.LDC_AB_BOADDRESSCHANGE';
END;
/