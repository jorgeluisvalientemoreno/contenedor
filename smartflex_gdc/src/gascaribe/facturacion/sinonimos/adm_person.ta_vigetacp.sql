PROMPT Crea Sinonimo a Tabla TA_VIGETACP
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.TA_VIGETACP FOR TA_VIGETACP';
END;
/