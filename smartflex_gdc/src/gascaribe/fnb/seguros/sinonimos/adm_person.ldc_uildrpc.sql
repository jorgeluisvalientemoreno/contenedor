PROMPT Crea sinonimo objeto LDC_UILDRPC
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM LDC_UILDRPC FOR ADM_PERSON.LDC_UILDRPC';
END;
/