PROMPT Crea Sinonimo a Tabla LDC_DETAREPOATECLI
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_DETAREPOATECLI FOR LDC_DETAREPOATECLI';
END;
/