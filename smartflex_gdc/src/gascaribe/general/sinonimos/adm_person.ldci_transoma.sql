PROMPT Crea Sinonimo a tabla LDCI_TRANSOMA
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDCI_TRANSOMA FOR LDCI_TRANSOMA';
END;
/