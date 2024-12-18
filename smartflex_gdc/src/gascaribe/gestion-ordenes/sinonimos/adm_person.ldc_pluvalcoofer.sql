PROMPT Crea sinonimo a la funciOn ldc_pluvalcoofer
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ldc_pluvalcoofer FOR ADM_PERSON.ldc_pluvalcoofer';
END;
/