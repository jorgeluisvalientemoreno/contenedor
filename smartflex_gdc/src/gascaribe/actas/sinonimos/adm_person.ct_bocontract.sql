PROMPT Crea Sinonimo a Paquete CT_BOCONTRACT
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.CT_BOCONTRACT FOR CT_BOCONTRACT';
END;
/