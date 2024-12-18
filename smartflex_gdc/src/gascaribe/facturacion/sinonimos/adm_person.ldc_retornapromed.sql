PROMPT Crea sinonimo a la funciOn ldc_retornapromed
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ldc_retornapromed FOR ADM_PERSON.ldc_retornapromed';
END;
/