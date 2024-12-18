PROMPT Crea sinonimo a la funciOn ldc_pcompressfile
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ldc_pcompressfile FOR ADM_PERSON.ldc_pcompressfile';
END;
/
