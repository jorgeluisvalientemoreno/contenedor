PROMPT Crea Sinonimo a paquete DAOR_RELATED_ORDER
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.DAOR_RELATED_ORDER FOR DAOR_RELATED_ORDER';
END;
/