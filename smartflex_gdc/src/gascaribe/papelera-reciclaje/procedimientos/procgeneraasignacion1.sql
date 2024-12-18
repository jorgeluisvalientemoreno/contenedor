set serveroutput on;
PROMPT Inicia procedimiento de borrado a PROCGENERAASIGNACION1 
DECLARE
  nuConta NUMBER;
BEGIN
  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = 'PROCGENERAASIGNACION1'
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE <> 'SYNONYM';
   
  IF nuConta > 0 THEN
    EXECUTE IMMEDIATE 'DROP PROCEDURE PROCGENERAASIGNACION1';
    dbms_output.put_line('procedimiento PROCGENERAASIGNACION1 --> borrado ');
  END IF;
EXCEPTION
    WHEN OTHERS THEN 
        dbms_output.put_line('No se pudo borrar el procedimiento PROCGENERAASIGNACION1 , '||sqlerrm); 
END;
/

