PROMPT Crea sinonimo objeto LDC_PKCONDICIONVISUALIZACION
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM LDC_PKCONDICIONVISUALIZACION FOR ADM_PERSON.LDC_PKCONDICIONVISUALIZACION';
END;
/
