PROMPT Crea sinonimo a la funciOn ldc_practualizacondsatab
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ldc_practualizacondsatab FOR ADM_PERSON.ldc_practualizacondsatab';
END;
/