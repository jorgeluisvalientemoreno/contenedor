PROMPT Crea sinonimo objeto dependiente LDC_PROCREATRAMITECERTI
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM LDC_PROCREATRAMITECERTI FOR ADM_PERSON.LDC_PROCREATRAMITECERTI';
END;
/
