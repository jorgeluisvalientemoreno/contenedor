PROMPT Crea Sinonimo a paquete LDC_CAMBIO_ESTADO_PROD para LDC_SUSPPORRPUSUVENC
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_CAMBIO_ESTADO_PROD FOR LDC_CAMBIO_ESTADO_PROD';
END;
/