set serveroutput on;
PROMPT Inicia procedimiento de borrado a LDC_VALIDA_DATO_ADI_MED_ADIC 
DECLARE
  nuConta NUMBER;
BEGIN
  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = 'LDC_VALIDA_DATO_ADI_MED_ADIC'
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE <> 'SYNONYM';
   
  IF nuConta > 0 THEN
    EXECUTE IMMEDIATE 'DROP PROCEDURE LDC_VALIDA_DATO_ADI_MED_ADIC';
    dbms_output.put_line('procedimiento LDC_VALIDA_DATO_ADI_MED_ADIC --> borrado ');
  END IF;
EXCEPTION
    WHEN OTHERS THEN 
        dbms_output.put_line('No se pudo borrar el procedimiento LDC_VALIDA_DATO_ADI_MED_ADIC , '||sqlerrm); 
END;
/

