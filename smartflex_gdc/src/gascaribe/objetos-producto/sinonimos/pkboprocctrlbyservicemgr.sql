PROMPT Crea Sinonimo ge_proc_sche_detail
BEGIN
	EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.pkboprocctrlbyservicemgr FOR OPEN.pkboprocctrlbyservicemgr';
END;
/