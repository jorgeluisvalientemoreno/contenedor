PROMPT Crea Sinonimo a tabla LDC_VARICERT
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_VARICERT FOR LDC_VARICERT';
END;
/