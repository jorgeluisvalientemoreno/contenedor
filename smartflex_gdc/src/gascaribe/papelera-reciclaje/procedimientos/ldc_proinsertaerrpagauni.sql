DECLARE
  nuConta NUMBER;
BEGIN

  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = 'LDC_PROINSERTAERRPAGAUNI'
   AND OWNER = 'ADM_PERSON'
   AND OBJECT_TYPE = 'SYNONYM';
   
  IF nuConta > 0 then
    EXECUTE IMMEDIATE 'DROP SYNONYM ADM_PERSON.LDC_PROINSERTAERRPAGAUNI';
  END IF; 

  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = 'LDC_PROINSERTAERRPAGAUNI'
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE = 'PROCEDURE';
   
  IF nuConta > 0 then
    EXECUTE IMMEDIATE 'DROP PROCEDURE  OPEN.LDC_PROINSERTAERRPAGAUNI';
  END IF;  
END;
/
