PROMPT Crea Sinonimo a Tabla LDC_GAVBR
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_GAVBR FOR  LDC_GAVBR';
END;
/