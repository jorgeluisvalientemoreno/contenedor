PROMPT Crea sinonimo objeto dependiente PKBOEXPIREDACCOUNTS
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.PKBOEXPIREDACCOUNTS FOR PKBOEXPIREDACCOUNTS';
END;
/