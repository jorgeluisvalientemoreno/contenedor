PROMPT Crea sinonimo objeto LDC_UIAPPROVEDREQUESTS
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM LDC_UIAPPROVEDREQUESTS FOR ADM_PERSON.LDC_UIAPPROVEDREQUESTS';
END;
/