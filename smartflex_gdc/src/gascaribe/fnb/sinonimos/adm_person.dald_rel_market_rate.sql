PROMPT Crea sinonimo objeto DALD_REL_MARKET_RATE
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM DALD_REL_MARKET_RATE FOR ADM_PERSON.DALD_REL_MARKET_RATE';
END;
/