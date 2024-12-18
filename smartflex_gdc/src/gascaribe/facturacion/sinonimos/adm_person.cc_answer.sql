PROMPT Crea Sinonimo a tabla cc_answer
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.cc_answer FOR cc_answer';
END;
/