DECLARE
  nuConta NUMBER;
BEGIN
  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = 'LDC_PRFILLTABLONBASE'
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE = 'PROCEDURE';
   
  IF nuConta > 0 then
    EXECUTE IMMEDIATE 'DROP PROCEDURE OPEN.LDC_PRFILLTABLONBASE';
  END IF;  
END;
/