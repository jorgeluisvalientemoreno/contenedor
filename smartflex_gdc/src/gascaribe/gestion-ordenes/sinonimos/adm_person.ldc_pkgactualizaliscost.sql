PROMPT Crea sinonimo objeto LDC_PKGACTUALIZALISCOST
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM LDC_PKGACTUALIZALISCOST FOR ADM_PERSON.LDC_PKGACTUALIZALISCOST';
END;
/