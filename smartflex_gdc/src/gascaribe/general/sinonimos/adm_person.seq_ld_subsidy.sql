PROMPT Crea sinonimo objeto dependiente SEQ_LD_SUBSIDY
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.SEQ_LD_SUBSIDY FOR SEQ_LD_SUBSIDY';
END;
/