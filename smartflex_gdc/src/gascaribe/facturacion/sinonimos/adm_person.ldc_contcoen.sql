PROMPT Crea Sinonimo a Tabla LDC_CONTCOEN
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_CONTCOEN FOR  LDC_CONTCOEN';
END;
/