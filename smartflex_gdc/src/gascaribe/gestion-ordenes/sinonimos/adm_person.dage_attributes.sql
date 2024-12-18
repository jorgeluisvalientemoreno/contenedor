PROMPT Crea Sinonimo a tabla dage_attributes
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.dage_attributes FOR dage_attributes';
END;
/