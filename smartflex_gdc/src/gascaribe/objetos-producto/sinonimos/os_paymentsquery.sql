BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.OS_PAYMENTSQUERY FOR OPEN.OS_PAYMENTSQUERY';
END;
/