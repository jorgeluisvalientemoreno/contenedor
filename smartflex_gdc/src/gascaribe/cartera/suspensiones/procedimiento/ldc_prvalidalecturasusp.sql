set serveroutput on;
PROMPT BORRAR PROCEDIMIENTO LDC_PRVALIDALECTURASUSP
DECLARE
  nuConta NUMBER;
BEGIN
  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = 'LDC_PRVALIDALECTURASUSP'
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE <> 'SYNONYM';
   
  IF nuConta > 0 then
    EXECUTE IMMEDIATE 'DROP PROCEDURE LDC_PRVALIDALECTURASUSP';
    dbms_output.put_line('PROCEDURE LDC_PRVALIDALECTURASUSP BORRADO ');
  END IF;
EXCEPTION
    WHEN OTHERS THEN 
        dbms_output.put_line('No se pudo borrar la procedimiento LDC_PRVALIDALECTURASUSP, '||sqlerrm); 
END;
/