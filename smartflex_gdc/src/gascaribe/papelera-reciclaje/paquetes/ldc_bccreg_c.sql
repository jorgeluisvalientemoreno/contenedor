DECLARE
  nuConta NUMBER;
BEGIN
  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = 'LDC_BCCREG_C'
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE = 'PACKAGE';
   
  IF nuConta > 0 then
    EXECUTE IMMEDIATE 'DROP PACKAGE OPEN.LDC_BCCREG_C';
  END IF;  
END;
/