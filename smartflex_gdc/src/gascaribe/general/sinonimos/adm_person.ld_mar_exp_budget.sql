PROMPT Crea Sinonimo a tabla LD_MAR_EXP_BUDGET
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LD_MAR_EXP_BUDGET FOR LD_MAR_EXP_BUDGET';
END;
/