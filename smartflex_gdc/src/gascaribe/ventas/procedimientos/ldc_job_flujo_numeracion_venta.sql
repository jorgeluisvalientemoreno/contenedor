DECLARE
  nuConta NUMBER;
BEGIN
  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = 'LDC_JOB_FLUJO_NUMERACION_VENTA'
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE = 'PROCEDURE';

  IF nuConta = 1 THEN
      EXECUTE IMMEDIATE 'DROP PROCEDURE OPEN.LDC_JOB_FLUJO_NUMERACION_VENTA';
  END IF;
END;
/