PROMPT Crea sinonimo objeto dependiente SEQ_LDC_APRFMLE
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.SEQ_LDC_APRFMLE FOR SEQ_LDC_APRFMLE';
END;
/
