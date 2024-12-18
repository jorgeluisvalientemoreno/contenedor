set serveroutput on;
PROMPT Inicia procedimiento de borrado a LDC_UNLOCKORDERS 
DECLARE
  nuConta NUMBER;
BEGIN
  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = 'LDC_UNLOCKORDERS'
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE <> 'SYNONYM';
   
  IF nuConta > 0 THEN
    EXECUTE IMMEDIATE 'DROP PROCEDURE LDC_UNLOCKORDERS';
    dbms_output.put_line('procedimiento LDC_UNLOCKORDERS --> borrado ');
  END IF;
EXCEPTION
    WHEN OTHERS THEN 
        dbms_output.put_line('No se pudo borrar el procedimiento LDC_UNLOCKORDERS , '||sqlerrm); 
END;
/

