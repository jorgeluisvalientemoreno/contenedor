PROMPT Crea sinonimo objeto dependiente LDC_METRAJE_TIPO_UNID_PRED
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_METRAJE_TIPO_UNID_PRED FOR LDC_METRAJE_TIPO_UNID_PRED';
END;
/