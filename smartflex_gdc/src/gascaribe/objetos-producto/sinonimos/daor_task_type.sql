PROMPT Crea Sinonimo DAOR_TASK_TYPE
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.DAOR_TASK_TYPE FOR DAOR_TASK_TYPE';
END;
/