PROMPT Crea Sinonimo a DALDC_TT_ACT
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM DALDC_TT_ACT FOR ADM_PERSON.DALDC_TT_ACT';
END;
/