DECLARE
  nuConta NUMBER;
BEGIN
  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = 'TOTAL_CART_MES_CONC'
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE = 'TABLE';
   
  IF nuConta > 0 then
    EXECUTE IMMEDIATE 'DROP TABLE OPEN.TOTAL_CART_MES_CONC';
  END IF;  
END;
/