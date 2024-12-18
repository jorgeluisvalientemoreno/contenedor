set serveroutput on;
PROMPT BORRAR PORUPDATESTATUSDOCORD
DECLARE
  nuConta NUMBER;
BEGIN
  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = 'PORUPDATESTATUSDOCORD'
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE <> 'SYNONYM';
   
  IF nuConta > 0 then
    EXECUTE IMMEDIATE 'DROP PROCEDURE PORUPDATESTATUSDOCORD';
  END IF;
EXCEPTION
    WHEN OTHERS THEN 
        dbms_output.put_line('No se pudo borrar procedimiento PORUPDATESTATUSDOCORD, '||sqlerrm); 
END;
/