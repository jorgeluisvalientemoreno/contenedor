PROMPT Crea sinonimo objeto LDC_MATBLOQANILLO
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM LDC_MATBLOQANILLO FOR ADM_PERSON.LDC_MATBLOQANILLO';
END;
/