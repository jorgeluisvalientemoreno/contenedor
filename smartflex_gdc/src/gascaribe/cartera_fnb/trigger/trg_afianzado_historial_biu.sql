DECLARE
  nuConta NUMBER;
BEGIN

  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = 'TRG_AFIANZADO_HISTORIAL_BIU'
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE = 'TRIGGER';
   
  IF nuConta > 0 then
    EXECUTE IMMEDIATE 'DROP TRIGGER OPEN.TRG_AFIANZADO_HISTORIAL_BIU';
  END IF;  
END;
/
