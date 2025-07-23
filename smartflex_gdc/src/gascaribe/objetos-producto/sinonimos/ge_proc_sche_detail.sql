PROMPT Crea Sinonimo ge_proc_sche_detail
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.ge_proc_sche_detail FOR OPEN.ge_proc_sche_detail';
END;
/