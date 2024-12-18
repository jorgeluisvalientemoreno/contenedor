PROMPT Crea sinonimo a la funciOn ldc_retornaaui_nivel
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ldc_retornaaui_nivel FOR ADM_PERSON.ldc_retornaaui_nivel';
END;
/