set serveroutput on;
PROMPT BORRAR LDC_BOSUSPPORSEGURIDAD
DECLARE
  nuConta       NUMBER;
  sbDueno	    VARCHAR2(30);
  sbobject_name	VARCHAR2(128);
  sbobject_type VARCHAR2(19);
BEGIN
    BEGIN
    dbms_output.put_Line('Preparando borrado de paquete OPEN.LDC_BOSUSPPORSEGURIDAD');
        SELECT COUNT(*), OWNER, OBJECT_NAME,  OBJECT_TYPE INTO nuConta, sbDueno, sbobject_name, sbobject_type
          FROM dba_objects
         WHERE object_name = 'LDC_BOSUSPPORSEGURIDAD'  
           AND OWNER = 'OPEN'
           AND OBJECT_TYPE ='PACKAGE'
         GROUP BY OWNER, OBJECT_NAME, OBJECT_TYPE;
         
    EXCEPTION WHEN OTHERS THEN
        nuConta:= 0;
        dbms_output.put_Line('paquete OPEN.LDC_BOSUSPPORSEGURIDAD no existe o fue borrado');
    END;
    dbms_output.put_line('Existe objeto(nuConta>0): '||nuConta);
    IF nuConta > 0 then
        EXECUTE IMMEDIATE 'DROP '||sbobject_type||' '||sbDueno||'.'||sbobject_name||'';
        dbms_output.put_Line(sbobject_type||' '||sbDueno||'.'||sbobject_name||' Borrado con exito!');
    END IF;
EXCEPTION
    WHEN OTHERS THEN 
        dbms_output.put_line('No se pudo borrar '||sbobject_type||' '||sbobject_name||', '||sqlerrm);  
END;
/