set serveroutput on;
PROMPT BORRAR LDC_PRVALFECHVENCFACTU
DECLARE
  nuConta NUMBER;
BEGIN
  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = 'LDC_PRVALFECHVENCFACTU'
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE <> 'SYNONYM';
   
  IF nuConta > 0 then
    EXECUTE IMMEDIATE 'DROP PROCEDURE LDC_PRVALFECHVENCFACTU';
  END IF;
EXCEPTION
    WHEN OTHERS THEN 
        dbms_output.put_line('No se pudo borrar procedimiento LDC_PRVALFECHVENCFACTU, '||sqlerrm); 
END;
/