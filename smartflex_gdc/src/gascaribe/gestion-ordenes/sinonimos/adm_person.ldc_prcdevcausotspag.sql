PROMPT Crea sinonimo a la funciOn ldc_prcdevcausotspag
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ldc_prcdevcausotspag FOR ADM_PERSON.ldc_prcdevcausotspag';
END;
/