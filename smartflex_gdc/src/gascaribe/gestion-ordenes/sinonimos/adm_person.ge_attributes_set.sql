PROMPT Crea Sinonimo a tabla ge_attributes_set
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.ge_attributes_set FOR ge_attributes_set';
END;
/