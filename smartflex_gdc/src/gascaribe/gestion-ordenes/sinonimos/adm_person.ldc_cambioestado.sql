PROMPT Crea sinonimo objeto LDC_CAMBIOESTADO
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM LDC_CAMBIOESTADO FOR ADM_PERSON.LDC_CAMBIOESTADO';
END;
/