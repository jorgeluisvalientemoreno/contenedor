DECLARE
  nuConta NUMBER;
BEGIN
  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = 'LDCBI_DESBLOQUEAR'
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE = 'PROCEDURE';
   
  IF nuConta > 0 then
    EXECUTE IMMEDIATE 'DROP PROCEDURE OPEN.LDCBI_DESBLOQUEAR';
  END IF;  
END;
/