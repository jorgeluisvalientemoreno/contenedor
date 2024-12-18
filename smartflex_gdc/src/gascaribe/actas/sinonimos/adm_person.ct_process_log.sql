PROMPT Crea Sinonimo a tabla ct_process_log
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.ct_process_log FOR ct_process_log';
END;
/