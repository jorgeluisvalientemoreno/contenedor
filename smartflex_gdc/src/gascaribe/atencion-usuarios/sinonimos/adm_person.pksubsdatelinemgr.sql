PROMPT Crea sinonimo objeto dependiente PKSUBSDATELINEMGR
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.PKSUBSDATELINEMGR FOR PKSUBSDATELINEMGR';
END;
/
