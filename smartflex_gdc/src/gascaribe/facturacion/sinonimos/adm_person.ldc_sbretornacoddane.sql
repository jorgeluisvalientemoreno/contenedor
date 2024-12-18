PROMPT Crea sinonimo a la funciOn ldc_sbretornacoddane
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ldc_sbretornacoddane FOR ADM_PERSON.ldc_sbretornacoddane';
END;
/