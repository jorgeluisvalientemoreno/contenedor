DECLARE
  nuConta NUMBER;
BEGIN

  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = 'LDCI_PKGESTNOVORDER'
   AND OWNER = 'ADM_PERSON'
   AND OBJECT_TYPE = 'SYNONYM';
   
  IF nuConta > 0 then
    EXECUTE IMMEDIATE 'DROP SYNONYM ADM_PERSON.LDCI_PKGESTNOVORDER';
  END IF;

  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = 'LDCI_PKGESTNOVORDER'
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE = 'PACKAGE';
   
  IF nuConta > 0 then
    EXECUTE IMMEDIATE 'DROP PACKAGE OPEN.LDCI_PKGESTNOVORDER';
  END IF;  
END;
/
