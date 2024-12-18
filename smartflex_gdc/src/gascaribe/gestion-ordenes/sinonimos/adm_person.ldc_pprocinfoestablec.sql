PROMPT Crea sinonimo a la funciOn ldc_pprocinfoestablec
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ldc_pprocinfoestablec FOR ADM_PERSON.ldc_pprocinfoestablec';
END;
/