set serveroutput on;
PROMPT BORRAR funcion FSBGETOBSNOLECT
DECLARE
  nuConta NUMBER;
BEGIN
  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = 'FSBGETOBSNOLECT'
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE <> 'SYNONYM';
   
  IF nuConta > 0 then
    EXECUTE IMMEDIATE 'DROP FUNCTION FSBGETOBSNOLECT';
  END IF;
EXCEPTION
    WHEN OTHERS THEN 
        dbms_output.put_line('No se pudo borrar la función FSBGETOBSNOLECT, '||sqlerrm); 
END;
/