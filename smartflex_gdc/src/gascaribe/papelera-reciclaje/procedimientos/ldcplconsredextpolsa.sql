set serveroutput on;
PROMPT Inicia procedimiento de borrado a LDCPLCONSREDEXTPOLSA 
DECLARE
  nuConta NUMBER;
BEGIN
  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = 'LDCPLCONSREDEXTPOLSA'
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE <> 'SYNONYM';
   
  IF nuConta > 0 THEN
    EXECUTE IMMEDIATE 'DROP PROCEDURE LDCPLCONSREDEXTPOLSA';
    dbms_output.put_line('procedimiento LDCPLCONSREDEXTPOLSA --> borrado ');
  END IF;
EXCEPTION
    WHEN OTHERS THEN 
        dbms_output.put_line('No se pudo borrar el procedimiento LDCPLCONSREDEXTPOLSA , '||sqlerrm); 
END;
/

