set serveroutput on;
PROMPT BORRAR LDC_USUARIOS_SUSP_Y_NOTI  
DECLARE
  nuConta       NUMBER;
  sbDueno	    VARCHAR2(30);
  sbobject_name	VARCHAR2(128);
  sbobject_type VARCHAR2(19);
BEGIN
    BEGIN
    dbms_output.put_Line('***Preparando borrado de synonym ADM_PERSON.LDC_USUARIOS_SUSP_Y_NOTI');
        SELECT  COUNT(*), OWNER, OBJECT_NAME, OBJECT_TYPE INTO nuConta, sbDueno, sbobject_name, sbobject_type
          FROM dba_objects
         WHERE object_name = 'LDC_USUARIOS_SUSP_Y_NOTI'
           AND OWNER = 'ADM_PERSON'
           AND OBJECT_TYPE = 'SYNONYM'
           GROUP BY OWNER, OBJECT_NAME, OBJECT_TYPE;
        dbms_output.put_line('Existe SYNONYM  '||nuConta);
    EXCEPTION WHEN OTHERS THEN
        nuConta:= 0;
        dbms_output.put_Line('synonym ADM_PERSON.LDC_USUARIOS_SUSP_Y_NOTI no existe o fue borrado');
    END;
    IF nuConta > 0 THEN
        EXECUTE IMMEDIATE 'DROP '||sbobject_type||' '||sbDueno||'.'||sbobject_name||'';
        dbms_output.put_line(sbobject_type||' '||sbDueno||'.'||sbobject_name||' BORRADO! ');
    END IF;

--
    BEGIN
    dbms_output.put_Line('***Preparando borrado de tabla OPEN.LDC_USUARIOS_SUSP_Y_NOTI');
        SELECT COUNT(*), OWNER, OBJECT_NAME, OBJECT_TYPE INTO nuConta, sbDueno, sbobject_name, sbobject_type
          FROM dba_objects
         WHERE object_name = 'LDC_USUARIOS_SUSP_Y_NOTI'  
           AND OWNER = 'OPEN'
           AND OBJECT_TYPE ='TABLE'
         GROUP BY OWNER, OBJECT_NAME, OBJECT_TYPE;
         dbms_output.put_line('Existe TABLE '||nuConta);
    EXCEPTION WHEN OTHERS THEN
        nuConta:= 0;
        dbms_output.put_Line('tabla OPEN.LDC_USUARIOS_SUSP_Y_NOTI no existe o fue borrado');
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