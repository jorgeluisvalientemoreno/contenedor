PROMPT Crea Sinonimo a Tabla LDC_INV_OUIB
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_INV_OUIB FOR LDC_INV_OUIB';
END;
/