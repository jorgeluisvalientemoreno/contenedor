PROMPT Crea sinonimo objeto LDC_PKG_CAMFEC
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM LDC_PKG_CAMFEC FOR ADM_PERSON.LDC_PKG_CAMFEC';
END;
/