set serveroutput on;
PROMPT Inicia procedimiento de borrado a PR_UPDATE_DATA_INSURED 
DECLARE
  nuConta NUMBER;
BEGIN
  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = 'PR_UPDATE_DATA_INSURED'
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE <> 'SYNONYM';
   
  IF nuConta > 0 THEN
    EXECUTE IMMEDIATE 'DROP PROCEDURE PR_UPDATE_DATA_INSURED';
    dbms_output.put_line('procedimiento PR_UPDATE_DATA_INSURED --> borrado ');
  END IF;
EXCEPTION
    WHEN OTHERS THEN 
        dbms_output.put_line('No se pudo borrar el procedimiento PR_UPDATE_DATA_INSURED , '||sqlerrm); 
END;
/

