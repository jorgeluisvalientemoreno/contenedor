DECLARE
 nuConta NUMBER;
BEGIN

 SELECT COUNT(*) INTO nuConta
 FROM dba_objects
 WHERE object_name = 'LD_BCQUOTATRANSFER'
  AND OWNER = 'ADM_PERSON'
  AND OBJECT_TYPE = 'SYNONYM';
  
 IF nuConta > 0 then
  EXECUTE IMMEDIATE 'DROP SYNONYM ADM_PERSON.LD_BCQUOTATRANSFER';
 END IF; 

 SELECT COUNT(*) INTO nuConta
 FROM dba_objects
 WHERE object_name = 'LD_BCQUOTATRANSFER'
  AND OWNER = 'OPEN'
  AND OBJECT_TYPE = 'PACKAGE';
  
 IF nuConta > 0 then
  EXECUTE IMMEDIATE 'DROP PACKAGE OPEN.LD_BCQUOTATRANSFER';
 END IF; 
END;
/
