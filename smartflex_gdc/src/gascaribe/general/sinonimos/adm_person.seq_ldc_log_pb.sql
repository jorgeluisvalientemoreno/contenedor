PROMPT Crea Sinonimo  SEQ_LDC_LOG_PB
BEGIN
 EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.SEQ_LDC_LOG_PB FOR SEQ_LDC_LOG_PB';
END;
/