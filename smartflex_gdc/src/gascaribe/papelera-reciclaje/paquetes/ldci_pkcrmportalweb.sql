DECLARE
  nuConta NUMBER;
BEGIN

  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = 'LDCI_PKCRMPORTALWEB'
   AND OWNER = 'ADM_PERSON'
   AND OBJECT_TYPE = 'SYNONYM';
   
  IF nuConta > 0 then
    EXECUTE IMMEDIATE 'DROP SYNONYM ADM_PERSON.LDCI_PKCRMPORTALWEB';
  END IF;

  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = 'LDCI_PKCRMPORTALWEB'
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE = 'PACKAGE';
   
  IF nuConta > 0 then
    EXECUTE IMMEDIATE 'DROP PACKAGE OPEN.LDCI_PKCRMPORTALWEB';
  END IF;  
END;
/