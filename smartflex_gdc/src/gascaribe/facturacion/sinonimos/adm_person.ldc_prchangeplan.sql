PROMPT Crea sinonimo a la funciOn ldc_prchangeplan
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ldc_prchangeplan FOR ADM_PERSON.ldc_prchangeplan';
END;
/