DECLARE
  nuConta NUMBER;
BEGIN
  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = 'LDC_CRMPAZYSALVO'
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE = 'PACKAGE';
   
  IF nuConta > 0 then
    EXECUTE IMMEDIATE 'DROP PACKAGE OPEN.LDC_CRMPAZYSALVO';
  END IF;  
END;
/