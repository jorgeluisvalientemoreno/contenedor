set serveroutput on;
PROMPT Inicia procedimiento de borrado a LDC_PROGORDTOUNLOCKTRABVAR 
DECLARE
  nuConta NUMBER;
BEGIN
  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = 'LDC_PROGORDTOUNLOCKTRABVAR'
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE <> 'SYNONYM';
   
  IF nuConta > 0 THEN
    EXECUTE IMMEDIATE 'DROP PROCEDURE LDC_PROGORDTOUNLOCKTRABVAR';
    dbms_output.put_line('procedimiento LDC_PROGORDTOUNLOCKTRABVAR --> borrado ');
  END IF;
EXCEPTION
    WHEN OTHERS THEN 
        dbms_output.put_line('No se pudo borrar el procedimiento LDC_PROGORDTOUNLOCKTRABVAR , '||sqlerrm); 
END;
/

