PROMPT Crea sinonimo objeto dependiente PKBCBILLINGNOTESCRDB
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.PKBCBILLINGNOTESCRDB FOR PKBCBILLINGNOTESCRDB';
END;
/