set serveroutput on;
PROMPT Inicia procedimiento de borrado a LDCDESENDNOTIFI 
DECLARE
  nuConta NUMBER;
BEGIN
  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = 'LDCDESENDNOTIFI'
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE <> 'SYNONYM';
   
  IF nuConta > 0 THEN
    EXECUTE IMMEDIATE 'DROP PROCEDURE LDCDESENDNOTIFI';
    dbms_output.put_line('procedimiento LDCDESENDNOTIFI --> borrado ');
  END IF;
EXCEPTION
    WHEN OTHERS THEN 
        dbms_output.put_line('No se pudo borrar el procedimiento LDCDESENDNOTIFI , '||sqlerrm); 
END;
/

