PROMPT Crea Sinonimo a tabla LD_CAUSAL
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LD_CAUSAL FOR LD_CAUSAL';
END;
/