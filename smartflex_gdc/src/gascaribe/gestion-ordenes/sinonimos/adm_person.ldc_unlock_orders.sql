PROMPT Crea Sinonimo  LDC_UNLOCK_ORDERS
BEGIN
 EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM LDC_UNLOCK_ORDERS FOR ADM_PERSON.LDC_UNLOCK_ORDERS';
END;
/
