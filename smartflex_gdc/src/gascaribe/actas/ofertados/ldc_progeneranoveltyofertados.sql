set serveroutput on;
PROMPT BORRAR PROCEDIMIENTO LDC_PROGENERANOVELTYOFERTADOS
DECLARE
  nuConta NUMBER;
BEGIN
  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = 'LDC_PROGENERANOVELTYOFERTADOS'
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE <> 'SYNONYM';
   
  IF nuConta > 0 then
    EXECUTE IMMEDIATE 'DROP PROCEDURE LDC_PROGENERANOVELTYOFERTADOS';
    dbms_output.put_line('PROCEDURE LDC_PROGENERANOVELTYOFERTADOS BORRADO');
  END IF;
EXCEPTION
    WHEN OTHERS THEN 
        dbms_output.put_line('No se pudo borrar el procedimiento LDC_PROGENERANOVELTYOFERTADOS, '||sqlerrm); 
END;
/