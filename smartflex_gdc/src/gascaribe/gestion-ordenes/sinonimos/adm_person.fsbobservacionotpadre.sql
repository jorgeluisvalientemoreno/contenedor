PROMPT Crea Sinonimo a función FSBOBSERVACIONOTPADRE
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM FSBOBSERVACIONOTPADRE FOR ADM_PERSON.FSBOBSERVACIONOTPADRE';
END;
/
