PROMPT Crea Sinonimo UT_EAN_CARDIF
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM UT_EAN_CARDIF FOR ADM_PERSON.UT_EAN_CARDIF';
END;
/
