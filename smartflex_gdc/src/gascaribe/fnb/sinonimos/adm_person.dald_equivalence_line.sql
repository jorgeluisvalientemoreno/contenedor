PROMPT Crea Sinonimo a DALD_EQUIVALENCE_LINE
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM DALD_EQUIVALENCE_LINE FOR ADM_PERSON.DALD_EQUIVALENCE_LINE';
END;
/