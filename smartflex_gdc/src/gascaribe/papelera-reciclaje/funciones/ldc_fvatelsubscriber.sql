DECLARE
  nuConta NUMBER;
BEGIN
  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = 'LDC_FVATELSUBSCRIBER'
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE <> 'SYNONYM';
   
  IF nuConta > 0 then
    EXECUTE IMMEDIATE 'DROP FUNCTION LDC_FVATELSUBSCRIBER';
  END IF;  
END;
/