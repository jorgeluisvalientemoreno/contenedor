PROMPT Crea Sinonimo CT_ORDER_CERTIFICA
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.CT_ORDER_CERTIFICA FOR CT_ORDER_CERTIFICA';
END;
/