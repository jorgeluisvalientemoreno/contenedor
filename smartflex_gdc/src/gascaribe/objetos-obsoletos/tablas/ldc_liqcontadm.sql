DECLARE
  nuConta NUMBER;
BEGIN
  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = 'LDC_LIQCONTADM'
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE = 'TABLE';
   
  IF nuConta > 0 then
     EXECUTE IMMEDIATE 'DROP TABLE OPEN.LDC_LIQCONTADM';
  END IF;  
END;
/