set serveroutput on;
PROMPT BORRAR PROCEDIMIENTO LDCPROCCREATRAMIFLUJOSPRPXML
DECLARE
  nuConta NUMBER;
BEGIN
  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = 'LDCPROCCREATRAMIFLUJOSPRPXML'
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE <> 'SYNONYM';
   
  IF nuConta > 0 then
    EXECUTE IMMEDIATE 'DROP PROCEDURE LDCPROCCREATRAMIFLUJOSPRPXML';
    dbms_output.put_line('PROCEDURE LDCPROCCREATRAMIFLUJOSPRPXML BORRADO');
  END IF;
EXCEPTION
    WHEN OTHERS THEN 
        dbms_output.put_line('No se pudo borrar el procedimiento LDCPROCCREATRAMIFLUJOSPRPXML, '||sqlerrm); 
END;
/