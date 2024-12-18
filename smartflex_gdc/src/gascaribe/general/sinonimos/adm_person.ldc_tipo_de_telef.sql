PROMPT Crea sinonimo a la funciOn ldc_tipo_de_telef
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ldc_tipo_de_telef FOR ADM_PERSON.ldc_tipo_de_telef';
END;
/