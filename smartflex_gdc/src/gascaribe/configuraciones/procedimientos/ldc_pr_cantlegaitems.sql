set serveroutput on;
PROMPT BORRAR PROCEDIMIENTO LDC_PR_CANTLEGAITEMS 
DECLARE
  nuConta NUMBER;
BEGIN
  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = 'LDC_PR_CANTLEGAITEMS'
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE <> 'SYNONYM';
   
  IF nuConta > 0 THEN
    EXECUTE IMMEDIATE 'DROP PROCEDURE LDC_PR_CANTLEGAITEMS';
    dbms_output.put_line('Borrar PROCEDURE LDC_PR_CANTLEGAITEMS  ');
  END IF;
EXCEPTION
    WHEN OTHERS THEN 
        dbms_output.put_line('No se pudo borrar el procedimiento LDC_PR_CANTLEGAITEMS , '||sqlerrm); 
END;
/

