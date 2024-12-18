DECLARE
  nuConta NUMBER;
BEGIN
  SELECT COUNT(1) INTO nuConta
  FROM DBA_SYNONYMS
  WHERE SYNONYM_NAME = 'OS_RELATED_ORDER'
   AND OWNER = 'ADM_PERSON';

  IF nuConta = 0 THEN
      EXECUTE IMMEDIATE 'create synonym adm_person.os_related_order for open.os_related_order';
  END IF;
END;
/