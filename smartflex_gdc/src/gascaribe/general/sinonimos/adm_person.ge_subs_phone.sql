PROMPT Crea Sinonimo a tabla ge_subs_phone
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.GE_SUBS_PHONE FOR GE_SUBS_PHONE';
END;
/