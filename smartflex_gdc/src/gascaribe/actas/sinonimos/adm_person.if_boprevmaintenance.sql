PROMPT Crea Sinonimo a Paquete IF_BOPREVMAINTENANCE
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.IF_BOPREVMAINTENANCE FOR IF_BOPREVMAINTENANCE';
END;
/