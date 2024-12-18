PROMPT Crea sinonimo a la funciOn ldc_practualizaotesdoc
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ldc_practualizaotesdoc FOR ADM_PERSON.ldc_practualizaotesdoc';
END;
/