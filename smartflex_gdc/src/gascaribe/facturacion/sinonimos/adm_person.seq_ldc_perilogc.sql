PROMPT Crea Sinonimo SEQ_LDC_PERILOGC
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.SEQ_LDC_PERILOGC FOR SEQ_LDC_PERILOGC';
END;
/