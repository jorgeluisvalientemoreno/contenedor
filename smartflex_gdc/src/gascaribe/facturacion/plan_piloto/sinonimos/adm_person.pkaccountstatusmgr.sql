PROMPT Crea Sinonimo a Paquete PKACCOUNTSTATUSMGR
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.PKACCOUNTSTATUSMGR FOR  PKACCOUNTSTATUSMGR';
END;
/