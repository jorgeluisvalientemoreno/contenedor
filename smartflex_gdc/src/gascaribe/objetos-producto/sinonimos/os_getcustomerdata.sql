BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.OS_GETCUSTOMERDATA FOR OPEN.OS_GETCUSTOMERDATA';
END;
/