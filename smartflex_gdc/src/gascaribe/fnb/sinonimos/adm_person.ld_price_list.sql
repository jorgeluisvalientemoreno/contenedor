PROMPT Crea sinonimo objeto dependiente LD_PRICE_LIST
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LD_PRICE_LIST FOR LD_PRICE_LIST';
END;
/
