PROMPT Crea Sinonimo a Secuencia SEQ_LDC_OR_ORDER_ITEMS_TEMP
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.SEQ_LDC_OR_ORDER_ITEMS_TEMP FOR SEQ_LDC_OR_ORDER_ITEMS_TEMP';
END;
/