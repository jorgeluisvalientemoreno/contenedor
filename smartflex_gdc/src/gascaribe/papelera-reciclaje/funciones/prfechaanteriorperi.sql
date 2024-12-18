set serveroutput on;
PROMPT BORRAR funcion PRFECHAANTERIORPERI
DECLARE
  nuConta NUMBER;
BEGIN
  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = 'PRFECHAANTERIORPERI'
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE <> 'SYNONYM';
   
  IF nuConta > 0 then
    EXECUTE IMMEDIATE 'DROP FUNCTION PRFECHAANTERIORPERI';
  END IF;
EXCEPTION
    WHEN OTHERS THEN 
        dbms_output.put_line('No se pudo borrar la función PRFECHAANTERIORPERI, '||sqlerrm); 
END;
/