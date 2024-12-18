set serveroutput on;
PROMPT BORRAR PROCEDIMIENTO PRSOLCUPPORWEB
DECLARE
  nuConta NUMBER;
BEGIN
  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = 'PRSOLCUPPORWEB'
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE <> 'SYNONYM';
   
  IF nuConta > 0 then
    EXECUTE IMMEDIATE 'DROP PROCEDURE PRSOLCUPPORWEB';
    dbms_output.put_line('PROCEDURE PRSOLCUPPORWEB BORRADO');
  END IF;
EXCEPTION
    WHEN OTHERS THEN 
        dbms_output.put_line('No se pudo borrar el procedimiento PRSOLCUPPORWEB, '||sqlerrm); 
END;
/