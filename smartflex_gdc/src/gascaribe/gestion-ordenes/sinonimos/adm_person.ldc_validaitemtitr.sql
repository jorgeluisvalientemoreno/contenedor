PROMPT Crea sinonimo objeto dependiente LDC_VALIDAITEMTITR
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM LDC_VALIDAITEMTITR FOR ADM_PERSON.LDC_VALIDAITEMTITR';
END;
/
