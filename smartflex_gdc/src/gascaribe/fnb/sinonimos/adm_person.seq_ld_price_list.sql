PROMPT Crea Sinonimo SEQ_LD_PRICE_LIST
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.SEQ_LD_PRICE_LIST FOR SEQ_LD_PRICE_LIST';
END;
/
