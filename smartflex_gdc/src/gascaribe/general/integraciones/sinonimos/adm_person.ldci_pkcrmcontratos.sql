PROMPT Crea Sinonimo LDCI_PKCRMCONTRATOS
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM LDCI_PKCRMCONTRATOS FOR ADM_PERSON.LDCI_PKCRMCONTRATOS';
END;
/