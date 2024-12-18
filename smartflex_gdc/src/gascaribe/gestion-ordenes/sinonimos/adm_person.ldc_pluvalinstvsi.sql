PROMPT Crea sinonimo a la funciOn ldc_pluvalinstvsi
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ldc_pluvalinstvsi FOR ADM_PERSON.ldc_pluvalinstvsi';
END;
/