PROMPT Crea Sinonimo LDC_UNPAID_TASK_TYPES
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_UNPAID_TASK_TYPES FOR LDC_UNPAID_TASK_TYPES';
END;
/
