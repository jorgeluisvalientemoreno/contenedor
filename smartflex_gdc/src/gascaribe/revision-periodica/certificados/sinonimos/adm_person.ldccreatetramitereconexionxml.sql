PROMPT Crea Sinonimo a procedimiento LDCCREATETRAMITERECONEXIONXML
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM LDCCREATETRAMITERECONEXIONXML FOR ADM_PERSON.LDCCREATETRAMITERECONEXIONXML';
END;
/