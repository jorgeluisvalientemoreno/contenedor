PROMPT Crea Sinonimo a tabla LDCI_NOVXTITRAB
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDCI_NOVXTITRAB FOR LDCI_NOVXTITRAB';
END;
/