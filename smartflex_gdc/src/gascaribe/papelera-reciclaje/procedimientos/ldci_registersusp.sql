DECLARE
  nuConta NUMBER;
BEGIN
SELECT COUNT(1) INTO nuConta
  FROM DBA_OBJECTS
  WHERE OBJECT_NAME = 'LDCI_REGISTERSUSP'
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE='PROCEDURE';

  IF nuConta >= 1 THEN
      EXECUTE IMMEDIATE 'DROP PROCEDURE OPEN.LDCI_REGISTERSUSP';
  END IF;
END;
/