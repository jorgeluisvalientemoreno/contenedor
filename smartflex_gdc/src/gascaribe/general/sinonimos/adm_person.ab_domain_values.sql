PROMPT Crea sinonimo objeto dependiente AB_DOMAIN_VALUES
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.AB_DOMAIN_VALUES FOR AB_DOMAIN_VALUES';
END;
/