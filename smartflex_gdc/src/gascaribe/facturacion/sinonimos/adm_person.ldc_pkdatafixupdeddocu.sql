PROMPT Crea sinonimo objeto LDC_PKDATAFIXUPDEDDOCU
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM LDC_PKDATAFIXUPDEDDOCU FOR ADM_PERSON.LDC_PKDATAFIXUPDEDDOCU';
END;
/