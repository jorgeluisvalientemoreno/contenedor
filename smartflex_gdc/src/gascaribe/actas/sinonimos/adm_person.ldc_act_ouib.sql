PROMPT Crea Sinonimo a Tabla LDC_ACT_OUIB
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_ACT_OUIB FOR LDC_ACT_OUIB';
END;
/