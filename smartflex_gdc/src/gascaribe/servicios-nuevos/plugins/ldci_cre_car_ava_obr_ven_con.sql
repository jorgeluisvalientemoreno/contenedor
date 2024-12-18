set serveroutput on;
PROMPT BORRAR PROCEDIMIENTO LDCI_CRE_CAR_AVA_OBR_VEN_CON
DECLARE
  nuConta NUMBER;
BEGIN
  SELECT COUNT(*) INTO nuConta
  FROM dba_objects
  WHERE object_name = 'LDCI_CRE_CAR_AVA_OBR_VEN_CON'
   AND OWNER = 'OPEN'
   AND OBJECT_TYPE <> 'SYNONYM';
   
  IF nuConta > 0 then
    EXECUTE IMMEDIATE 'DROP PROCEDURE LDCI_CRE_CAR_AVA_OBR_VEN_CON';
    dbms_output.put_line('PROCEDURE LDCI_CRE_CAR_AVA_OBR_VEN_CON BORRADO');
  END IF;
EXCEPTION
    WHEN OTHERS THEN 
        dbms_output.put_line('No se pudo borrar el procedimiento LDCI_CRE_CAR_AVA_OBR_VEN_CON, '||sqlerrm); 
END;
/