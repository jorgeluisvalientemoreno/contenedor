PROMPT Crea sinonimo a la funciOn ldc_retornaconcidecaje
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ldc_retornaconcidecaje FOR ADM_PERSON.ldc_retornaconcidecaje';
END;
/