DECLARE
  nuConta NUMBER;
BEGIN
  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = 'LOG_CERTIFICADOS_OIA'
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE = 'PROCEDURE';
   
  IF nuConta > 0 then
    EXECUTE IMMEDIATE 'DROP PROCEDURE OPEN.LOG_CERTIFICADOS_OIA';
  END IF;  
END;
/