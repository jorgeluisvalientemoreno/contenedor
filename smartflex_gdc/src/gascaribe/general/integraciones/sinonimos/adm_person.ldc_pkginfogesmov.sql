PROMPT Crea sinonimo objeto LDC_PKGINFOGESMOV
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM LDC_PKGINFOGESMOV FOR ADM_PERSON.LDC_PKGINFOGESMOV';
END;
/