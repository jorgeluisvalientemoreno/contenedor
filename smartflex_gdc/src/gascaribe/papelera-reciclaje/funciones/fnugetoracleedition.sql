set serveroutput on;
PROMPT BORRAR funcion FNUGETORACLEEDITION
DECLARE
  nuConta NUMBER;
BEGIN
  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = 'FNUGETORACLEEDITION'
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE <> 'SYNONYM';
   
  IF nuConta > 0 then
    EXECUTE IMMEDIATE 'DROP FUNCTION FNUGETORACLEEDITION';
  END IF;
EXCEPTION
    WHEN OTHERS THEN 
        dbms_output.put_line('No se pudo borrar la función FNUGETORACLEEDITION, '||sqlerrm); 
END;
/