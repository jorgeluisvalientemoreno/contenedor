PROMPT Crea sinonimo objeto LDC_PKGENEORADI
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM LDC_PKGENEORADI FOR ADM_PERSON.LDC_PKGENEORADI';
END;
/
