PROMPT Crea sinonimo objeto LDC_DSEQUIVA_LOCALIDAD
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM LDC_DSEQUIVA_LOCALIDAD FOR ADM_PERSON.LDC_DSEQUIVA_LOCALIDAD';
END;
/