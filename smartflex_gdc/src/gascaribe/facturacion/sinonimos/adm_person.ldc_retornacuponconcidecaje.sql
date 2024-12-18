PROMPT Crea sinonimo a la funciOn ldc_retornacuponconcidecaje
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ldc_retornacuponconcidecaje FOR ADM_PERSON.ldc_retornacuponconcidecaje';
END;
/