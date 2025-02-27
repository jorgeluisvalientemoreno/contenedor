DECLARE
  nuConta NUMBER;
BEGIN

  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = 'TRGAURLD_VALIDITY_POLICY_TYPE'
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE = 'TRIGGER';
   
  IF nuConta > 0 then
    EXECUTE IMMEDIATE 'DROP TRIGGER OPEN.TRGAURLD_VALIDITY_POLICY_TYPE';
  END IF;  
END;
/
