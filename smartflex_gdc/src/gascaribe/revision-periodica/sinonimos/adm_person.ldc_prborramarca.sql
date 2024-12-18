PROMPT Crea sinonimo a la funciOn ldc_prborramarca
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ldc_prborramarca FOR ADM_PERSON.ldc_prborramarca';
END;
/