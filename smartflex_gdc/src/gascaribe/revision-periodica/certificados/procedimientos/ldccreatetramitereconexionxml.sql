set serveroutput on;
PROMPT BORRAR PROCEDIMIENTO LDCCREATETRAMITERECONEXIONXML
DECLARE
  nuConta NUMBER;
BEGIN
  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = 'LDCCREATETRAMITERECONEXIONXML'
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE <> 'SYNONYM';
   
  IF nuConta > 0 then
    EXECUTE IMMEDIATE 'DROP PROCEDURE LDCCREATETRAMITERECONEXIONXML';
    dbms_output.put_line('PROCEDURE LDCCREATETRAMITERECONEXIONXML BORRADO');
  END IF;
EXCEPTION
    WHEN OTHERS THEN 
        dbms_output.put_line('No se pudo borrar el procedimiento LDCCREATETRAMITERECONEXIONXML, '||sqlerrm); 
END;
/