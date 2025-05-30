set serveroutput on;
PROMPT BORRAR funcion LDC_CONSULTACERTVIGTEC
DECLARE
  nuConta NUMBER;
BEGIN
  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = 'LDC_CONSULTACERTVIGTEC'
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE <> 'SYNONYM';
   
  IF nuConta > 0 then
    EXECUTE IMMEDIATE 'DROP FUNCTION LDC_CONSULTACERTVIGTEC';
  END IF;
EXCEPTION
    WHEN OTHERS THEN 
        dbms_output.put_line('No se pudo borrar la función LDC_CONSULTACERTVIGTEC, '||sqlerrm); 
END;
/