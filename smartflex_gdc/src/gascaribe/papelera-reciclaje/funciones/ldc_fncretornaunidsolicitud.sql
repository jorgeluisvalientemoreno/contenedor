set serveroutput on;
PROMPT BORRAR funcion LDC_FNCRETORNAUNIDSOLICITUD EN OPEN y SYNONYM DE ADM_PERSON
DECLARE
  nuConta NUMBER;
BEGIN
    BEGIN
      SELECT COUNT(*) INTO nuConta
      FROM dba_objects
      WHERE object_name = 'LDC_FNCRETORNAUNIDSOLICITUD'
       AND OWNER = 'ADM_PERSON'
       AND OBJECT_TYPE = 'SYNONYM';
       dbms_output.put_line('Borrar SYNONYM ADM_PERSON.LDC_FNCRETORNAUNIDSOLICITUD ');
      IF nuConta > 0 then
        EXECUTE IMMEDIATE 'DROP SYNONYM ADM_PERSON.LDC_FNCRETORNAUNIDSOLICITUD';
      END IF;
    EXCEPTION
        WHEN OTHERS THEN 
            dbms_output.put_line('No se pudo borrar la función LDC_FNCRETORNAUNIDSOLICITUD, '||sqlerrm); 
    END;      
    
    BEGIN
    nuConta:= 0;
      SELECT COUNT(*) INTO nuConta
      FROM dba_objects
      WHERE object_name = 'LDC_FNCRETORNAUNIDSOLICITUD'
       AND OWNER = 'OPEN'
       AND OBJECT_TYPE <> 'SYNONYM';
       
      IF nuConta > 0 then
        EXECUTE IMMEDIATE 'DROP FUNCTION LDC_FNCRETORNAUNIDSOLICITUD';
      END IF;
      dbms_output.put_line('Borrar SYNONYM OPEN.LDC_FNCRETORNAUNIDSOLICITUD ');
    EXCEPTION
        WHEN OTHERS THEN 
            dbms_output.put_line('No se pudo borrar la función LDC_FNCRETORNAUNIDSOLICITUD, '||sqlerrm); 
    END;
END;
/