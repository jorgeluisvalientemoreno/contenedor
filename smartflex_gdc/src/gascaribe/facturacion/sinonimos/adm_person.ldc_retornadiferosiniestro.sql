PROMPT Crea sinonimo a la funciOn ldc_retornadiferosiniestro
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ldc_retornadiferosiniestro FOR ADM_PERSON.ldc_retornadiferosiniestro';
END;
/