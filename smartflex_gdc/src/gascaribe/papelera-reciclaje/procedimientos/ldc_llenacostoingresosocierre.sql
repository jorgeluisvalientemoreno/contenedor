DECLARE
  nuConta NUMBER;
BEGIN
  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = 'LDC_LLENACOSTOINGRESOSOCIERRE'
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE = 'PROCEDURE';
   
  IF nuConta > 0 then
    EXECUTE IMMEDIATE 'DROP PROCEDURE OPEN.LDC_LLENACOSTOINGRESOSOCIERRE';
  END IF;  
<<<<<<< HEAD
=======
   
>>>>>>> c14f37f1 (OSF-2533: Implementar Procedimientos en el esquema ADM_PERSON - GDC 3)
END;
/