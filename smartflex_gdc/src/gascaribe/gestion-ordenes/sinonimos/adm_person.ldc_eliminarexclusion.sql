PROMPT Crea sinonimo objeto LDC_ELIMINAREXCLUSION
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM LDC_ELIMINAREXCLUSION FOR ADM_PERSON.LDC_ELIMINAREXCLUSION';
END;
/
