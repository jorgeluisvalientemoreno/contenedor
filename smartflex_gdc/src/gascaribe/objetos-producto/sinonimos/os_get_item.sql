BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.OS_GET_ITEM FOR OPEN.OS_GET_ITEM';
END;
/