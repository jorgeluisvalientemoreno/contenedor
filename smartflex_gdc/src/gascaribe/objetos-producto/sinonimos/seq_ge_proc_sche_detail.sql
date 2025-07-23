PROMPT Crea Sinonimo seq_ge_proc_sche_detail
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.seq_ge_proc_sche_detail FOR OPEN.seq_ge_proc_sche_detail';
END;
/