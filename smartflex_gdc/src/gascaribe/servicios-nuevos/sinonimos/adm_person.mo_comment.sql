PROMPT Crea Sinonimo a tabla MO_COMMENT para LDCI_CRE_CAR_AVA_OBR_VEN_CON
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.MO_COMMENT FOR MO_COMMENT';
END;
/