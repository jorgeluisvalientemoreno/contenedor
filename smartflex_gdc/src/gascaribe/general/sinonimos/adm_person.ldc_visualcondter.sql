PROMPT Crea sinonimo a la funciOn ldc_visualcondter
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ldc_visualcondter FOR ADM_PERSON.ldc_visualcondter';
END;
/