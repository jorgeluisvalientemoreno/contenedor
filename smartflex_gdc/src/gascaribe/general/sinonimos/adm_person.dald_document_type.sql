PROMPT Crea Sinonimo a DALD_DOCUMENT_TYPE
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM DALD_DOCUMENT_TYPE FOR ADM_PERSON.DALD_DOCUMENT_TYPE';
END;
/