PROMPT Crea sinonimo objeto dependiente LDC_OSSEXCLUYEPNO
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM LDC_OSSEXCLUYEPNO FOR ADM_PERSON.LDC_OSSEXCLUYEPNO';
END;
/