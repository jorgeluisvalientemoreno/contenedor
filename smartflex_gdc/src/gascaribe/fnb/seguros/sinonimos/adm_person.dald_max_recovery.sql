PROMPT Crea Sinonimo a DALD_MAX_RECOVERY
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM DALD_MAX_RECOVERY FOR ADM_PERSON.DALD_MAX_RECOVERY';
END;
/