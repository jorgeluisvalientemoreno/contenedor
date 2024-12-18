set serveroutput on;
PROMPT BORRAR GDC_PRTSDWFINSTATTRIB1210214  
DECLARE
  nuConta       NUMBER;
  sbDueno	    VARCHAR2(30);
  sbobject_name	VARCHAR2(128);
  sbobject_type VARCHAR2(19);
BEGIN
    BEGIN
    dbms_output.put_Line('***Preparando borrado de Procedure OPEN.GDC_PRTSDWFINSTATTRIB1210214');
        SELECT COUNT(*), OWNER, OBJECT_NAME, OBJECT_TYPE INTO nuConta, sbDueno, sbobject_name, sbobject_type
          FROM dba_objects
         WHERE object_name = 'GDC_PRTSDWFINSTATTRIB1210214'  
           AND OWNER = 'OPEN'
           AND OBJECT_TYPE ='PROCEDURE'
         GROUP BY OWNER, OBJECT_NAME, OBJECT_TYPE;
         dbms_output.put_line('Existe Procedure '||nuConta);
    EXCEPTION WHEN OTHERS THEN
        nuConta:= 0;
        dbms_output.put_Line('Procedure OPEN.GDC_PRTSDWFINSTATTRIB1210214 no existe o fue borrado');
    END;
    IF nuConta > 0 then
        EXECUTE IMMEDIATE 'DROP '||sbobject_type||' '||sbDueno||'.'||sbobject_name||'';
        dbms_output.put_Line(sbobject_type||' '||sbDueno||'.'||sbobject_name||' BORRADO con éxito!');
    END IF;
  --
EXCEPTION
    WHEN OTHERS THEN 
        dbms_output.put_line('No se pudo borrar '||sbobject_type||' '||sbobject_name||', '||sqlerrm); 
END;
/
