PROMPT Crea Sinonimo a tabla LD_SUBSIDY_DETAIL
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LD_SUBSIDY_DETAIL FOR LD_SUBSIDY_DETAIL';
END;
/
