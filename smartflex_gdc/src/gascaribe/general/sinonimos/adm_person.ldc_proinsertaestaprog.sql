PROMPT Crea Sinonimo a LDC_PROINSERTAESTAPROG
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM LDC_PROINSERTAESTAPROG FOR ADM_PERSON.LDC_PROINSERTAESTAPROG';
END;
/