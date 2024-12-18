PROMPT Crea sinonimo a la funciOn ldc_validaordeninstance
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ldc_validaordeninstance FOR ADM_PERSON.ldc_validaordeninstance';
END;
/