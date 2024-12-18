DECLARE
  nuConta NUMBER;
BEGIN
  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = upper('procgeneracupon_bcolombia')
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE = 'PROCEDURE';
   
  IF nuConta > 0 then
    EXECUTE IMMEDIATE 'DROP PROCEDURE OPEN.procgeneracupon_bcolombia';
  END IF;  
END;
/