PROMPT Crea Sinonimo MO_GAS_SALE_DATA
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.MO_GAS_SALE_DATA FOR MO_GAS_SALE_DATA';
END;
/