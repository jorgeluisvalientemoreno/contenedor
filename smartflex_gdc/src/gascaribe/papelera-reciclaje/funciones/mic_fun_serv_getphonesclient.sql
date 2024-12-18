set serveroutput on;
PROMPT BORRAR funcion MIC_FUN_SERV_GETPHONESCLIENT
DECLARE
  nuConta NUMBER;
BEGIN
  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = 'MIC_FUN_SERV_GETPHONESCLIENT'
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE <> 'SYNONYM';
   
  IF nuConta > 0 then
    EXECUTE IMMEDIATE 'DROP FUNCTION MIC_FUN_SERV_GETPHONESCLIENT';
  END IF;
EXCEPTION
    WHEN OTHERS THEN 
        dbms_output.put_line('No se pudo borrar la función MIC_FUN_SERV_GETPHONESCLIENT, '||sqlerrm); 
END;
/