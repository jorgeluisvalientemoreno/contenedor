PROMPT Crea sinonimo objeto dependiente SEQ_CAMFEC
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.SEQ_CAMFEC FOR SEQ_CAMFEC';
END;
/
