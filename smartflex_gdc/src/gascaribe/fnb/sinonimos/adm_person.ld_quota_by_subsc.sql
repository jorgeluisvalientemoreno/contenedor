PROMPT Crea sinonimo objeto dependiente LD_QUOTA_BY_SUBSC
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LD_QUOTA_BY_SUBSC FOR LD_QUOTA_BY_SUBSC';
END;
/