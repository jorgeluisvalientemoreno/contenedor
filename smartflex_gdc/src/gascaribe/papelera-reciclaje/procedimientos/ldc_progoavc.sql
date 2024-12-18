set serveroutput on;
PROMPT Inicia procedimiento de borrado a LDC_PROGOAVC 
DECLARE
  nuConta NUMBER;
BEGIN
  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = 'LDC_PROGOAVC'
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE <> 'SYNONYM';
   
  IF nuConta > 0 THEN
    EXECUTE IMMEDIATE 'DROP PROCEDURE LDC_PROGOAVC';
    dbms_output.put_line('procedimiento LDC_PROGOAVC --> borrado ');
  END IF;
EXCEPTION
    WHEN OTHERS THEN 
        dbms_output.put_line('No se pudo borrar el procedimiento LDC_PROGOAVC , '||sqlerrm); 
END;
/

