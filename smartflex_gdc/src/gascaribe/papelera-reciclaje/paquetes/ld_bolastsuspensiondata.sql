DECLARE
  nuConta NUMBER;
BEGIN
  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = 'LD_BOLASTSUSPENSIONDATA'
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE = 'PACKAGE';
   
  IF nuConta > 0 then
    EXECUTE IMMEDIATE 'DROP PACKAGE OPEN.LD_BOLASTSUSPENSIONDATA';
  END IF;  
END;
/