PROMPT Crea sinonimo objeto dependiente LDC_PROVALIREGENSERVNUEVOS
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM LDC_PROVALIREGENSERVNUEVOS FOR ADM_PERSON.LDC_PROVALIREGENSERVNUEVOS';
END;
/