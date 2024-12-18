set serveroutput on;
PROMPT BORRAR LDCPROCGENORDENAPOYO
DECLARE
  nuConta NUMBER;
BEGIN
  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = 'LDCPROCGENORDENAPOYO'
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE <> 'SYNONYM';
   
  IF nuConta > 0 then
    EXECUTE IMMEDIATE 'DROP PROCEDURE LDCPROCGENORDENAPOYO';
  END IF;
EXCEPTION
    WHEN OTHERS THEN 
        dbms_output.put_line('No se pudo borrar procedimiento LDCPROCGENORDENAPOYO, '||sqlerrm); 
END;
/