PROMPT Crea sinonimo objeto LDC_PKGENOTADIFE
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM LDC_PKGENOTADIFE FOR ADM_PERSON.LDC_PKGENOTADIFE';
END;
/
