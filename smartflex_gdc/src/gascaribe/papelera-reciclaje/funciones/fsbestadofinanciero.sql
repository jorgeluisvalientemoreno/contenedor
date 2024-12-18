set serveroutput on;
PROMPT BORRAR funcion FSBESTADOFINANCIERO
DECLARE
  nuConta NUMBER;
BEGIN
  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = 'FSBESTADOFINANCIERO'
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE <> 'SYNONYM';
   
  IF nuConta > 0 then
    EXECUTE IMMEDIATE 'DROP FUNCTION FSBESTADOFINANCIERO';
  END IF;
EXCEPTION
    WHEN OTHERS THEN 
        dbms_output.put_line('No se pudo borrar la función FSBESTADOFINANCIERO, '||sqlerrm); 
END;
/