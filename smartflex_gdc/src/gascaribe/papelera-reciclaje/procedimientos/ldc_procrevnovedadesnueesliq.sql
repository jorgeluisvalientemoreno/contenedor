set serveroutput on;
PROMPT BORRAR LDC_PROCREVNOVEDADESNUEESLIQ
DECLARE
  nuConta NUMBER;
BEGIN
  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = 'LDC_PROCREVNOVEDADESNUEESLIQ'
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE <> 'SYNONYM';
   
  IF nuConta > 0 then
    EXECUTE IMMEDIATE 'DROP PROCEDURE LDC_PROCREVNOVEDADESNUEESLIQ';
  END IF;
EXCEPTION
    WHEN OTHERS THEN 
        dbms_output.put_line('No se pudo borrar procedimiento LDC_PROCREVNOVEDADESNUEESLIQ, '||sqlerrm); 
END;
/