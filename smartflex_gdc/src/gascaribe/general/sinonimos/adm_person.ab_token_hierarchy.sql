PROMPT Crea sinonimo objeto dependiente AB_TOKEN_HIERARCHY
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.AB_TOKEN_HIERARCHY FOR AB_TOKEN_HIERARCHY';
END;
/