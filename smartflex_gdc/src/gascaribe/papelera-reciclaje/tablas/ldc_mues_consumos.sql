DECLARE
  nuConta NUMBER;
BEGIN
  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = 'LDC_MUES_CONSUMOS'
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE = 'TABLE';
   
  IF nuConta > 0 then
    EXECUTE IMMEDIATE 'DROP TABLE OPEN.LDC_MUES_CONSUMOS';
  END IF;  
END;
/