PROMPT Crea sinonimo a la funciOn ldc_pr_valida_orden_30
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ldc_pr_valida_orden_30 FOR ADM_PERSON.ldc_pr_valida_orden_30';
END;
/