DECLARE
  nuConta NUMBER;
BEGIN
  SELECT COUNT(1) INTO nuConta
  FROM DBA_SYNONYMS
  WHERE SYNONYM_NAME = 'OS_LEGALIZEORDERS'
   AND OWNER = 'PERSONALIZACIONES';

  IF nuConta = 0 THEN
      EXECUTE IMMEDIATE 'DROP SYNONYM PERSONALIZACIONES.OS_LEGALIZEORDERS';
  END IF;
END;
/