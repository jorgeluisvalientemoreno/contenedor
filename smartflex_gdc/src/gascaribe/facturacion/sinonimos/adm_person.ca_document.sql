PROMPT Crea Sinonimo a tabla ca_document
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.ca_document FOR ca_document';
END;
/