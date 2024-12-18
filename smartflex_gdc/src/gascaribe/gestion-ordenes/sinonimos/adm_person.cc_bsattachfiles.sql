PROMPT Crea Sinonimo a tabla cc_bsattachfiles
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.cc_bsattachfiles FOR cc_bsattachfiles';
END;
/