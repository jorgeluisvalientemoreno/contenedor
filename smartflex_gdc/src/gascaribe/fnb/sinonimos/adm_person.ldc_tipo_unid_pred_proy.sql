PROMPT Crea sinonimo objeto dependiente LDC_TIPO_UNID_PRED_PROY
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_TIPO_UNID_PRED_PROY FOR LDC_TIPO_UNID_PRED_PROY';
END;
/