PROMPT Crea Sinonimo a tabla ld_quota_block
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.ld_quota_block FOR ld_quota_block';
END;
/