PROMPT Crea sinonimo objeto dependiente LDC_CLIENTE_ESPECIAL
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_CLIENTE_ESPECIAL FOR LDC_CLIENTE_ESPECIAL';
END;
/
