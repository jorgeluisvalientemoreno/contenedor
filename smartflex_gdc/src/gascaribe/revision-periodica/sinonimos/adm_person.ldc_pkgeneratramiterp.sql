PROMPT Crea sinonimo objeto LDC_PKGENERATRAMITERP
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM LDC_PKGENERATRAMITERP FOR ADM_PERSON.LDC_PKGENERATRAMITERP';
END;
/
