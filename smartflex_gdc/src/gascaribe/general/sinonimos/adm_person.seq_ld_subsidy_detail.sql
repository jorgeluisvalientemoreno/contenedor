PROMPT Crea sinonimo objeto dependiente SEQ_LD_SUBSIDY_DETAIL
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.SEQ_LD_SUBSIDY_DETAIL FOR SEQ_LD_SUBSIDY_DETAIL';
END;
/
