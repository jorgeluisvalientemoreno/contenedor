PROMPT Crea Sinonimo a tabla ge_attributes
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.ge_attributes FOR ge_attributes';
END;
/