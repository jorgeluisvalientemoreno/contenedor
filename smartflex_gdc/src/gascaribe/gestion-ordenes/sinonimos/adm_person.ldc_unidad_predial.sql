PROMPT Crea sinonimo objeto dependiente LDC_UNIDAD_PREDIAL
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_UNIDAD_PREDIAL FOR LDC_UNIDAD_PREDIAL';
END;
/