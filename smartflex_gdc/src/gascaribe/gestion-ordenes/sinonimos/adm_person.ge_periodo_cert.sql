PROMPT Crea Sinonimo a tabla GE_PERIODO_CERT
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.GE_PERIODO_CERT FOR GE_PERIODO_CERT';
END;
/