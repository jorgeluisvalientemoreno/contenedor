PROMPT Crea Sinonimo a Tabla LDC_OSF_CONTRATO
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_OSF_CONTRATO FOR LDC_OSF_CONTRATO';
END;
/