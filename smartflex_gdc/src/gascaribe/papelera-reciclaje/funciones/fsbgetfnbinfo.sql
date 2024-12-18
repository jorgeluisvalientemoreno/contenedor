set serveroutput on;
PROMPT BORRAR funcion FSBGETFNBINFO EN OPEN y SYNONYM DE ADM_PERSON
DECLARE
  nuConta NUMBER;
BEGIN
    BEGIN
      SELECT COUNT(*) INTO nuConta
      FROM dba_objects
      WHERE object_name = 'FSBGETFNBINFO'
       AND OWNER = 'ADM_PERSON'
       AND OBJECT_TYPE = 'SYNONYM';
       dbms_output.put_line('nuConta '||nuConta);
      IF nuConta > 0 then
        dbms_output.put_line('Borrar SYNONYM ADM_PERSON.FSBGETFNBINFO ');
		EXECUTE IMMEDIATE 'DROP SYNONYM ADM_PERSON.FSBGETFNBINFO';
      END IF;
    EXCEPTION
        WHEN OTHERS THEN 
            dbms_output.put_line('No se pudo borrar el synonym ADM_PERSON.FSBGETFNBINFO, '||sqlerrm); 
    END;      
    
    BEGIN
    nuConta:= 0;
      SELECT COUNT(*) INTO nuConta
      FROM dba_objects
      WHERE object_name = 'FSBGETFNBINFO'
       AND OWNER = 'OPEN'
       AND OBJECT_TYPE <> 'SYNONYM';
       dbms_output.put_line('nuConta '||nuConta);
      IF nuConta > 0 then
        dbms_output.put_line('Borrar FUNCTION FSBGETFNBINFO ');
		EXECUTE IMMEDIATE 'DROP FUNCTION FSBGETFNBINFO';
      END IF;
    EXCEPTION
        WHEN OTHERS THEN 
            dbms_output.put_line('No se pudo borrar la función FSBGETFNBINFO, '||sqlerrm); 
    END;
END;
/