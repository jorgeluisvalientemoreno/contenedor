PROMPT Crea Sinonimo a Tabla TMPHILOCARGDIF
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.TMPHILOCARGDIF FOR TMPHILOCARGDIF';
END;
/