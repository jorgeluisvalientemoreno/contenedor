PROMPT Crea sinonimo objeto dependiente PKBOACCOUNTINGINTERFACE
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.PKBOACCOUNTINGINTERFACE FOR PKBOACCOUNTINGINTERFACE';
END;
/