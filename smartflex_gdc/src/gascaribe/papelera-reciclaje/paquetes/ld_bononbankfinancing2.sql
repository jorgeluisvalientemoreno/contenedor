DECLARE
  nuConta NUMBER;
BEGIN
SELECT COUNT(1) INTO nuConta
  FROM DBA_OBJECTS
  WHERE OBJECT_NAME = 'LD_BONONBANKFINANCING2'
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE='PACKAGE';

  IF nuConta >= 1 THEN
      EXECUTE IMMEDIATE 'DROP PACKAGE OPEN.LD_BONONBANKFINANCING2';
  END IF;
END;
/