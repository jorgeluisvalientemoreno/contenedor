PROMPT Crea sinonimo a la funciOn ldc_tele_prefijo
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ldc_tele_prefijo FOR ADM_PERSON.ldc_tele_prefijo';
END;
/