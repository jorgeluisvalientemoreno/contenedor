PROMPT Crea sinonimo a la funciOn ldc_tecnicos_certificado
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ldc_tecnicos_certificado FOR ADM_PERSON.ldc_tecnicos_certificado';
END;
/