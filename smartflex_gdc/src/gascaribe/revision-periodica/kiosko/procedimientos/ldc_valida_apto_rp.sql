set serveroutput on;
PROMPT BORRAR PROCEDIMIENTO LDC_VALIDA_APTO_RP
DECLARE
  nuConta NUMBER;
BEGIN
  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = 'LDC_VALIDA_APTO_RP'
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE <> 'SYNONYM';
   
  IF nuConta > 0 then
    EXECUTE IMMEDIATE 'DROP PROCEDURE LDC_VALIDA_APTO_RP';
    dbms_output.put_line('PROCEDURE LDC_VALIDA_APTO_RP BORRADO');
  END IF;
EXCEPTION
    WHEN OTHERS THEN 
        dbms_output.put_line('No se pudo borrar el procedimiento LDC_VALIDA_APTO_RP, '||sqlerrm); 
END;
/