PROMPT Crea Sinonimo a Tabla LDC_INFOPRNORP
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_INFOPRNORP FOR  LDC_INFOPRNORP';
END;
/