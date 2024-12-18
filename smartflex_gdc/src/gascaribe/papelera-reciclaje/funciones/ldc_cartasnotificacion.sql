set serveroutput on;
PROMPT BORRAR funcion LDC_CARTASNOTIFICACION
DECLARE
  nuConta NUMBER;
BEGIN
  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = 'LDC_CARTASNOTIFICACION'
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE <> 'SYNONYM';
   
  IF nuConta > 0 then
    EXECUTE IMMEDIATE 'DROP FUNCTION LDC_CARTASNOTIFICACION';
  END IF;
EXCEPTION
    WHEN OTHERS THEN 
        dbms_output.put_line('No se pudo borrar la función LDC_CARTASNOTIFICACION, '||sqlerrm);
END;
/