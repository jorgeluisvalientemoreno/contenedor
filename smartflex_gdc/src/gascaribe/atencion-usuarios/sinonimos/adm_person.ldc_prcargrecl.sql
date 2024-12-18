PROMPT Crea sinonimo a la funciOn ldc_prcargrecl
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ldc_prcargrecl FOR ADM_PERSON.ldc_prcargrecl';
END;
/