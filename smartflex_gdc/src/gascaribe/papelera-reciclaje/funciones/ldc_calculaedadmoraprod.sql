set serveroutput on;
PROMPT BORRAR funcion LDC_CALCULAEDADMORAPROD
DECLARE
  nuConta NUMBER;
BEGIN
  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = 'LDC_CALCULAEDADMORAPROD'
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE <> 'SYNONYM';
   
  IF nuConta > 0 then
    EXECUTE IMMEDIATE 'DROP FUNCTION LDC_CALCULAEDADMORAPROD';
  END IF;
EXCEPTION
    WHEN OTHERS THEN 
        dbms_output.put_line('No se pudo borrar la función LDC_CALCULAEDADMORAPROD, '||sqlerrm); 
END;
/