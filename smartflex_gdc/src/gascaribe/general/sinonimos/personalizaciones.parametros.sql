DECLARE
  nuConta number;
BEGIN
   SELECT COUNT(*) INTO nuConta
  FROM dba_synonyms
  WHERE table_name = 'PARAMETROS' 
  AND OWNER = 'ADM_PERSON';

   --se borran sinonimos
  IF nuConta > 0 THEN
     EXECUTE IMMEDIATE 'DROP SYNONYM ADM_PERSON.PARAMETROS';
  END IF;  
  
  SELECT COUNT(*) INTO nuConta
  FROM dba_synonyms
  WHERE table_name = 'PARAMETROS' 
  AND OWNER = 'INNOVACION';
  
  IF nuConta > 0 THEN
    EXECUTE IMMEDIATE 'DROP SYNONYM INNOVACION.PARAMETROS';
  END IF;  

  SELECT COUNT(*) INTO nuConta
  FROM dba_synonyms
  WHERE table_name = 'PARAMETROS' 
  AND OWNER = 'OPEN';

  IF nuConta > 0 THEN
    EXECUTE IMMEDIATE 'DROP SYNONYM OPEN.PARAMETROS';
  END IF;

END;
/