PROMPT Crea Sinonimo LDCI_ACTIVOENCURSO
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDCI_ACTIVOENCURSO FOR LDCI_ACTIVOENCURSO';
END;
/