DECLARE
  nuConta NUMBER;
BEGIN
  SELECT COUNT(1) INTO nuConta
  FROM DBA_SYNONYMS
  WHERE SYNONYM_NAME = 'ERRORS'
   AND OWNER = 'ADM_PERSON';

  IF nuConta = 0 THEN
      EXECUTE IMMEDIATE 'CREATE SYNONYM ADM_PERSON.ERRORS FOR OPEN.ERRORS';
  END IF;
END;
/