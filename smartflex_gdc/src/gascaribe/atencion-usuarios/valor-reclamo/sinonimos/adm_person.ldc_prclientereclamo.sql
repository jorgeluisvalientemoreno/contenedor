PROMPT Crea sinonimo a la funciOn ldc_prclientereclamo
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ldc_prclientereclamo FOR ADM_PERSON.ldc_prclientereclamo';
END;
/