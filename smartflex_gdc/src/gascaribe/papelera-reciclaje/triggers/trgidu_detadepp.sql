DECLARE
  nuConta NUMBER;
BEGIN

  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = 'TRGIDU_DETADEPP'
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE = 'TRIGGER';
   
  IF nuConta > 0 then
    EXECUTE IMMEDIATE 'DROP TRIGGER OPEN.TRGIDU_DETADEPP';
  END IF;  
END;
/
