PROMPT Crea sinonimo objeto LDC_BCFORMATO_COTI_COM
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM LDC_BCFORMATO_COTI_COM FOR ADM_PERSON.LDC_BCFORMATO_COTI_COM';
END;
/