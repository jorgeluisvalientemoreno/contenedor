set serveroutput on;
PROMPT BORRAR DALDC_ORDEN_LODPD  
DECLARE
  nuConta       NUMBER;
  sbDueno	    VARCHAR2(30);
  sbobject_name	VARCHAR2(128);
  sbobject_type VARCHAR2(19);
BEGIN
    BEGIN
    dbms_output.put_Line('***Preparando borrado de synonym ADM_PERSON.DALDC_ORDEN_LODPD');
        SELECT  COUNT(*), OWNER, OBJECT_NAME, OBJECT_TYPE INTO nuConta, sbDueno, sbobject_name, sbobject_type
          FROM dba_objects
         WHERE object_name = 'DALDC_ORDEN_LODPD'
           AND OWNER = 'ADM_PERSON'
           AND OBJECT_TYPE = 'SYNONYM'
           GROUP BY OWNER, OBJECT_NAME, OBJECT_TYPE;
        dbms_output.put_line('Existe SYNONYM  '||nuConta);
    EXCEPTION WHEN OTHERS THEN
        nuConta:= 0;
        dbms_output.put_Line('synonym ADM_PERSON.DALDC_ORDEN_LODPD no existe o fue borrado');
    END;
    IF nuConta > 0 THEN
        EXECUTE IMMEDIATE 'DROP '||sbobject_type||' '||sbDueno||'.'||sbobject_name||'';
        dbms_output.put_line(sbobject_type||' '||sbDueno||'.'||sbobject_name||' BORRADO! ');
    END IF;

--
    BEGIN
    dbms_output.put_Line('***Preparando borrado de procedimiento OPEN.DALDC_ORDEN_LODPD');
        SELECT COUNT(*), OWNER, OBJECT_NAME, OBJECT_TYPE INTO nuConta, sbDueno, sbobject_name, sbobject_type
          FROM dba_objects
         WHERE object_name = 'DALDC_ORDEN_LODPD'  
           AND OWNER = 'OPEN'
           AND OBJECT_TYPE ='PACKAGE'
         GROUP BY OWNER, OBJECT_NAME, OBJECT_TYPE;
         dbms_output.put_line('Existe PROCEDURE '||nuConta);
    EXCEPTION WHEN OTHERS THEN
        nuConta:= 0;
        dbms_output.put_Line('procedimiento OPEN.DALDC_ORDEN_LODPD no existe o fue borrado');
    END;
    IF nuConta > 0 then
        EXECUTE IMMEDIATE 'DROP '||sbobject_type||' '||sbDueno||'.'||sbobject_name||'';
        dbms_output.put_Line(sbobject_type||' '||sbDueno||'.'||sbobject_name||' BORRADO');
    END IF;
  --
EXCEPTION
    WHEN OTHERS THEN 
        dbms_output.put_line('No se pudo borrar '||sbobject_type||' '||sbobject_name||', '||sqlerrm); 
END;
/