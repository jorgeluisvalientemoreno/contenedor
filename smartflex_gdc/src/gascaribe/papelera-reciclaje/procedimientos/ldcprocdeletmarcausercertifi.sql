set serveroutput on;
PROMPT Inicia procedimiento de borrado a LDCPROCDELETMARCAUSERCERTIFI 
DECLARE
  nuConta NUMBER;
BEGIN
  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = 'LDCPROCDELETMARCAUSERCERTIFI'
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE <> 'SYNONYM';
   
  IF nuConta > 0 THEN
    EXECUTE IMMEDIATE 'DROP PROCEDURE LDCPROCDELETMARCAUSERCERTIFI';
    dbms_output.put_line('procedimiento LDCPROCDELETMARCAUSERCERTIFI --> borrado ');
  END IF;
EXCEPTION
    WHEN OTHERS THEN 
        dbms_output.put_line('No se pudo borrar el procedimiento LDCPROCDELETMARCAUSERCERTIFI , '||sqlerrm); 
END;
/

