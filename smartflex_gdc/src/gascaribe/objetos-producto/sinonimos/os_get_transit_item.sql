BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.OS_GET_TRANSIT_ITEM FOR OPEN.OS_GET_TRANSIT_ITEM';
END;
/