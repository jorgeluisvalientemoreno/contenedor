BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.OS_GETCUSTUSERSBYPROD FOR OPEN.OS_GETCUSTUSERSBYPROD';
END;
/