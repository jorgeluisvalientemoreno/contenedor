PROMPT Crea sinonimo objeto dependiente LDC_PRIO_TIPO_PROD_GESTCOBR
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_PRIO_TIPO_PROD_GESTCOBR FOR LDC_PRIO_TIPO_PROD_GESTCOBR';
END;
/