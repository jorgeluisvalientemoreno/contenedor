PROMPT Crea Sinonimo a DALD_CONSE_HISTORIC_SALES
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM DALD_CONSE_HISTORIC_SALES FOR ADM_PERSON.DALD_CONSE_HISTORIC_SALES';
END;
/
