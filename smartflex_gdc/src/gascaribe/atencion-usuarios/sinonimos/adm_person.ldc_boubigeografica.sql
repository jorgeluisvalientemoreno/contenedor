PROMPT Crea sinonimo objeto LDC_BOUBIGEOGRAFICA
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM LDC_BOUBIGEOGRAFICA FOR ADM_PERSON.LDC_BOUBIGEOGRAFICA';
END;
/