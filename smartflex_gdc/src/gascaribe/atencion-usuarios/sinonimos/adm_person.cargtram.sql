PROMPT Crea Sinonimo a tabla cargtram
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.cargtram FOR cargtram';
END;
/