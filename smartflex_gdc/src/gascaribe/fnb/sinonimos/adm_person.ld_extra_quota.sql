PROMPT Crea Sinonimo a tabla LD_EXTRA_QUOTA
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LD_EXTRA_QUOTA FOR LD_EXTRA_QUOTA';
END;
/