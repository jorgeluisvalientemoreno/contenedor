PROMPT Crea sinonimo objeto LDC_UILDCPBLEORD
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM LDC_UILDCPBLEORD FOR ADM_PERSON.LDC_UILDCPBLEORD';
END;
/