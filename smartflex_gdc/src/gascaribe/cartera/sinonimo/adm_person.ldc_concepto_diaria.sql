PROMPT Crea Sinonimo  LDC_CONCEPTO_DIARIA 
BEGIN
 EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_CONCEPTO_DIARIA FOR LDC_CONCEPTO_DIARIA';
END;
/