DECLARE
  nuConta NUMBER;
BEGIN
SELECT COUNT(1) INTO nuConta
  FROM DBA_OBJECTS
  WHERE OBJECT_NAME = 'LDC_LEG_IPLI_ASIG'
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE='PACKAGE';

  IF nuConta >= 1 THEN
      EXECUTE IMMEDIATE 'DROP PACKAGE OPEN.LDC_LEG_IPLI_ASIG';
  END IF;
END;
/