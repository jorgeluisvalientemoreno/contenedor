PROMPT Crea Sinonimo OR_ACTIV_DEFECT
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.OR_ACTIV_DEFECT FOR OR_ACTIV_DEFECT';
END;
/