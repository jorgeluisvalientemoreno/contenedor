DECLARE
  nuConta NUMBER;
BEGIN
  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = 'LDC_OSF_REPOCONSUMOS'
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE = 'TABLE';
   
  IF nuConta > 0 then
    EXECUTE IMMEDIATE 'DROP TABLE OPEN.LDC_OSF_REPOCONSUMOS';
  END IF;  
END;
/