PROMPT Crea sinonimo objeto dependiente SEQ_LD_QUOTA_BY_SUBSC
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.SEQ_LD_QUOTA_BY_SUBSC FOR SEQ_LD_QUOTA_BY_SUBSC';
END;
/