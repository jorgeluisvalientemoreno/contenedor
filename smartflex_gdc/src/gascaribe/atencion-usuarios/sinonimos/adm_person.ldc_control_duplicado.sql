PROMPT Crea sinonimo objeto dependiente LDC_CONTROL_DUPLICADO
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_CONTROL_DUPLICADO FOR LDC_CONTROL_DUPLICADO';
END;
/
