 DECLARE
  nuConta number;
BEGIN 
   SELECT COUNT(*) INTO nuConta
  FROM dba_synonyms
  WHERE table_name = 'PKG_PARAMETROS' 
  AND OWNER = 'ADM_PERSON';
   
  IF nuConta > 0 THEN
    EXECUTE IMMEDIATE 'DROP SYNONYM ADM_PERSON.pkg_parametros';
  END IF;
  
   SELECT COUNT(*) INTO nuConta
  FROM dba_synonyms
  WHERE table_name = 'PKG_PARAMETROS' 
  AND OWNER = 'INNOVACION';
   
  IF nuConta > 0 THEN
    EXECUTE IMMEDIATE 'DROP SYNONYM INNOVACION.pkg_parametros';
  END IF;

   SELECT COUNT(*) INTO nuConta
  FROM dba_synonyms
  WHERE table_name = 'PKG_PARAMETROS' 
  AND OWNER = 'OPEN';
   
  IF nuConta > 0 THEN

    EXECUTE IMMEDIATE 'DROP SYNONYM OPEN.pkg_parametros';
  END IF;
  
END;
/