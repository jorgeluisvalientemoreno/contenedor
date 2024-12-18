set serveroutput on;
PROMPT BORRAR synonym LDC_PRODEVUELVEVALORESCUOTAS  
DECLARE
  nuConta       NUMBER;
  sbDueno	    VARCHAR2(30);
  sbobject_name	VARCHAR2(128);
  sbobject_type VARCHAR2(19);
BEGIN
    BEGIN
    dbms_output.put_Line('Preparando borrado de synonym ADM_PERSON.LDC_PRODEVUELVEVALORESCUOTAS');
        SELECT  COUNT(*), OWNER, OBJECT_NAME, OBJECT_TYPE INTO nuConta, sbDueno, sbobject_name, sbobject_type
          FROM dba_objects
         WHERE object_name = 'LDC_PRODEVUELVEVALORESCUOTAS'
           AND OWNER = 'OPEN'
           AND OBJECT_TYPE = 'SYNONYM'
           GROUP BY OWNER, OBJECT_NAME, OBJECT_TYPE;
        dbms_output.put_line('Existe SYNONYM OPEN '||nuConta);
    EXCEPTION WHEN OTHERS THEN
        nuConta:= 0;
        dbms_output.put_Line(sbobject_type||' '||sbobject_name||' no existe o fue borrado');
    END;
    IF nuConta > 0 THEN                
            dbms_output.put_line('El procedimiento '||sbobject_name||' ya fue migrado! ');
    ELSE
         EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.LDC_PRODEVUELVEVALORESCUOTAS FOR LDC_PRODEVUELVEVALORESCUOTAS';
         dbms_output.put_line(sbobject_type||' '||sbDueno||'.'||sbobject_name||' CREADO! ');
    END IF;
 
  --
EXCEPTION
    WHEN OTHERS THEN 
        dbms_output.put_line('No se pudo crear '||sbobject_type||' '||sbobject_name||', '||sqlerrm); 
END;
/
