PROMPT Crea Sinonimo a tabla ca_detadocu
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.ca_detadocu FOR ca_detadocu';
END;
/