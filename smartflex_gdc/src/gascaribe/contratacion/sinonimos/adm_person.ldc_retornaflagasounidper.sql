PROMPT Crea sinonimo a la funciOn ldc_retornaflagasounidper
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ldc_retornaflagasounidper FOR ADM_PERSON.ldc_retornaflagasounidper';
END;
/