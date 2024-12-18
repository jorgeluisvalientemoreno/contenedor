PROMPT Crea sinonimo a la funciOn ldc_prcambmedidorprepago
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ldc_prcambmedidorprepago FOR ADM_PERSON.ldc_prcambmedidorprepago';
END;
/