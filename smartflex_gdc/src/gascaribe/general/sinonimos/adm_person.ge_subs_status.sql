PROMPT Crea Sinonimo GE_SUBS_STATUS
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.GE_SUBS_STATUS FOR GE_SUBS_STATUS';
END;
/