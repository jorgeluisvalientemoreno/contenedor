PROMPT Crea Sinonimo a tabla LD_CREDIT_QUOTA
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LD_CREDIT_QUOTA FOR LD_CREDIT_QUOTA';
END;
/