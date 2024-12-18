PROMPT Crea Sinonimo a tabla cc_commercial_plan
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.cc_commercial_plan FOR cc_commercial_plan';
END;
/