PROMPT Crea Sinonimo a DALD_LIQUIDATION_SELLER
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM DALD_LIQUIDATION_SELLER FOR ADM_PERSON.DALD_LIQUIDATION_SELLER';
END;
/