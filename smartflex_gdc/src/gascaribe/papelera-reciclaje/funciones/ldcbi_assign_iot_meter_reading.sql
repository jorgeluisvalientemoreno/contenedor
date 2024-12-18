set serveroutput on;
PROMPT BORRAR funcion LDCBI_ASSIGN_IOT_METER_READING
DECLARE
  nuConta NUMBER;
BEGIN
  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = 'LDCBI_ASSIGN_IOT_METER_READING'
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE <> 'SYNONYM';
   
  IF nuConta > 0 then
    EXECUTE IMMEDIATE 'DROP FUNCTION LDCBI_ASSIGN_IOT_METER_READING';
  END IF;
EXCEPTION
    WHEN OTHERS THEN 
        dbms_output.put_line('No se pudo borrar la función LDCBI_ASSIGN_IOT_METER_READING, '||sqlerrm);
END;
/