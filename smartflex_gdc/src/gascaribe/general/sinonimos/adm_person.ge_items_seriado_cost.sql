PROMPT Crea sinonimo objeto dependiente GE_ITEMS_SERIADO_COST
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.GE_ITEMS_SERIADO_COST FOR GE_ITEMS_SERIADO_COST';
END;
/