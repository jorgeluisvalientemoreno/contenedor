PROMPT Crea Sinonimo  DAGE_ITEMS
BEGIN
 EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.DAGE_ITEMS FOR DAGE_ITEMS';
END;
/