PROMPT Crea sinonimo objeto dependiente SEQ_LDC_APRFMACO
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.SEQ_LDC_APRFMACO FOR SEQ_LDC_APRFMACO';
END;
/
