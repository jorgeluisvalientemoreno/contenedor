PROMPT Crea Sinonimo a tabla LDC_ESTACION_REGULA
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_ESTACION_REGULA FOR LDC_ESTACION_REGULA';
END;
/