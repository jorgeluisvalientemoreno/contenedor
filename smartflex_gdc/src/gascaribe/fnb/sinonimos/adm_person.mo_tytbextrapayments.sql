PROMPT Crea Sinonimo MO_TYTBEXTRAPAYMENTS
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.MO_TYTBEXTRAPAYMENTS FOR MO_TYTBEXTRAPAYMENTS';
END;
/