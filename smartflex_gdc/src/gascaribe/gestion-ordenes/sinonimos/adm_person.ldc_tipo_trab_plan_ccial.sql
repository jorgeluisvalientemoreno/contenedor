PROMPT Crea Sinonimo a tabla LDC_TIPO_TRAB_PLAN_CCIAL
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_TIPO_TRAB_PLAN_CCIAL FOR LDC_TIPO_TRAB_PLAN_CCIAL';
END;
/