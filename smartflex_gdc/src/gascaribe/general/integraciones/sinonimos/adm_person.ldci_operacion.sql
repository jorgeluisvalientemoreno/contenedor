PROMPT Crea Sinonimo LDCI_OPERACION
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDCI_OPERACION FOR LDCI_OPERACION';
END;
/