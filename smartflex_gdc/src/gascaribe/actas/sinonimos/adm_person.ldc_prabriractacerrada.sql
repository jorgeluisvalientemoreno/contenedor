PROMPT Crea sinonimo a la funciOn ldc_prabriractacerrada
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ldc_prAbrirActaCerrada FOR ADM_PERSON.ldc_prabriractacerrada';
END;
/