PROMPT Crea sinonimo objeto dependiente LDC_TIPO_METOD_ESTRAT
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_TIPO_METOD_ESTRAT FOR LDC_TIPO_METOD_ESTRAT';
END;
/