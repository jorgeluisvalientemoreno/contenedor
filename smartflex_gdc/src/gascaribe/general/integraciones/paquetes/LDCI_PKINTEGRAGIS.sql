DECLARE
  nuConta NUMBER;
BEGIN
  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = 'LDCI_PKINTEGRAGIS'
   AND OWNER = 'ADM_PERSON'
   AND OBJECT_TYPE = 'PACKAGE';
   
  IF nuConta > 0 then
    EXECUTE IMMEDIATE 'DROP PACKAGE ADM_PERSON.LDCI_PKINTEGRAGIS';
  END IF;  
END;
/