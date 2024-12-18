set serveroutput on;
PROMPT BORRAR funcion FSBEXISTSINSTANSUBSC
DECLARE
  nuConta NUMBER;
BEGIN
  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = 'FSBEXISTSINSTANSUBSC'
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE <> 'SYNONYM';
   
  IF nuConta > 0 then
    EXECUTE IMMEDIATE 'DROP FUNCTION FSBEXISTSINSTANSUBSC';
  END IF;
EXCEPTION
    WHEN OTHERS THEN 
        dbms_output.put_line('No se pudo borrar la función FSBEXISTSINSTANSUBSC, '||sqlerrm);
END;
/