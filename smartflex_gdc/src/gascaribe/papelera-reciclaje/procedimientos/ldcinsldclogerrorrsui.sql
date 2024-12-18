set serveroutput on;
PROMPT BORRAR LDCINSLDCLOGERRORRSUI
DECLARE
  nuConta NUMBER;
BEGIN
  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = 'LDCINSLDCLOGERRORRSUI'
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE <> 'SYNONYM';
   
  IF nuConta > 0 then
    EXECUTE IMMEDIATE 'DROP PROCEDURE LDCINSLDCLOGERRORRSUI';
  END IF;
EXCEPTION
    WHEN OTHERS THEN 
        dbms_output.put_line('No se pudo borrar procedimiento LDCINSLDCLOGERRORRSUI, '||sqlerrm); 
END;
/