PROMPT Crea sinonimo objeto dependiente LDC_PROREG_CT_PROCESS_LOG
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM LDC_PROREG_CT_PROCESS_LOG FOR ADM_PERSON.LDC_PROREG_CT_PROCESS_LOG';
END;
/
