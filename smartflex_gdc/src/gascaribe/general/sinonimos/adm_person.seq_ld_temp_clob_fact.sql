PROMPT Crea sinonimo objeto dependiente SEQ_LD_TEMP_CLOB_FACT
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.SEQ_LD_TEMP_CLOB_FACT FOR SEQ_LD_TEMP_CLOB_FACT';
END;
/