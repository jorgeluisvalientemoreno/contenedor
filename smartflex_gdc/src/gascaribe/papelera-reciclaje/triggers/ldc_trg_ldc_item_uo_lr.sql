DECLARE
  nuConta NUMBER;
BEGIN

  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = 'LDC_TRG_LDC_ITEM_UO_LR'
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE = 'TRIGGER';
   
  IF nuConta > 0 then
    EXECUTE IMMEDIATE 'DROP TRIGGER OPEN.LDC_TRG_LDC_ITEM_UO_LR';
  END IF;  
END;
/