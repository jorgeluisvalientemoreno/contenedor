PROMPT Crea Sinonimo a paquete DAGE_ITEMS_SERIADO para LDC_VALIDA_DATO_ADI_MED_ADIC
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.DAGE_ITEMS_SERIADO FOR DAGE_ITEMS_SERIADO';
END;
/