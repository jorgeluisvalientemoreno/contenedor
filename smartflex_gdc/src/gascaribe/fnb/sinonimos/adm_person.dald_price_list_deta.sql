PROMPT Crea Sinonimo a DALD_PRICE_LIST_DETA
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM DALD_PRICE_LIST_DETA FOR ADM_PERSON.DALD_PRICE_LIST_DETA';
END;
/