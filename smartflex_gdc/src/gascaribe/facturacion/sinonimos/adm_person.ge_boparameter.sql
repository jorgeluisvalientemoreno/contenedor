PROMPT Crea Sinonimo a tabla ge_boparameter
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.ge_boparameter FOR ge_boparameter';
END;
/