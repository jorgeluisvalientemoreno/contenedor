PROMPT Crea Sinonimo a tabla LD_FINAN_PLAN_FNB
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LD_FINAN_PLAN_FNB FOR LD_FINAN_PLAN_FNB';
END;
/