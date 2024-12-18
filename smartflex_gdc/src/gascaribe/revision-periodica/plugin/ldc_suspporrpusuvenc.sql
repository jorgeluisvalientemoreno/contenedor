set serveroutput on;
PROMPT BORRAR PROCEDIMIENTO LDC_SUSPPORRPUSUVENC
DECLARE
  nuConta NUMBER;
BEGIN
  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = 'LDC_SUSPPORRPUSUVENC'
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE <> 'SYNONYM';
   
  IF nuConta > 0 then
    EXECUTE IMMEDIATE 'DROP PROCEDURE LDC_SUSPPORRPUSUVENC';
    dbms_output.put_line('PROCEDURE LDC_SUSPPORRPUSUVENC BORRADO');
  END IF;
EXCEPTION
    WHEN OTHERS THEN 
        dbms_output.put_line('No se pudo borrar el procedimiento LDC_SUSPPORRPUSUVENC, '||sqlerrm); 
END;
/