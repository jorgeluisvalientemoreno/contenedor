PROMPT Crea sinonimo objeto dependiente LDC_AUDIT_CUOT_PROY
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_AUDIT_CUOT_PROY FOR LDC_AUDIT_CUOT_PROY';
END;
/