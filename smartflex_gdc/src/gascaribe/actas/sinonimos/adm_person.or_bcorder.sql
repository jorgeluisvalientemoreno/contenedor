PROMPT Crea Sinonimo a Paquete OR_BCORDER
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.OR_BCORDER FOR OR_BCORDER';
END;
/