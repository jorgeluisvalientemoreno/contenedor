PROMPT Crea sinonimo objeto LDC_PKPAGOSCONSIG
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM LDC_PKPAGOSCONSIG FOR ADM_PERSON.LDC_PKPAGOSCONSIG';
END;
/