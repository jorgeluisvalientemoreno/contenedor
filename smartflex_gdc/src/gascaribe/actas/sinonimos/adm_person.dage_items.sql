PROMPT Crea Sinonimo a paquete DAGE_ITEMS para LDC_VALIDA_DATO_ADI_MED_ADIC
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.DAGE_ITEMS FOR DAGE_ITEMS';
END;
/