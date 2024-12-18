set serveroutput on;
PROMPT BORRAR DALD_INCONS_FNB_EXITO  
DECLARE
  nuConta       NUMBER;
  sbDueno	    VARCHAR2(30);
  sbobject_name	VARCHAR2(128);
  sbobject_type VARCHAR2(19);
BEGIN
    BEGIN
    dbms_output.put_Line('Preparando borrado de paquete OPEN.DALD_INCONS_FNB_EXITO');
        SELECT COUNT(*), OWNER, OBJECT_NAME,  OBJECT_TYPE INTO nuConta, sbDueno, sbobject_name, sbobject_type
          FROM dba_objects
         WHERE object_name = 'DALD_INCONS_FNB_EXITO'  
           AND OWNER = 'OPEN'
           AND OBJECT_TYPE ='PACKAGE'
         GROUP BY OWNER, OBJECT_NAME, OBJECT_TYPE;
         
    EXCEPTION WHEN OTHERS THEN
        nuConta:= 0;
        dbms_output.put_Line('paquete OPEN.DALD_INCONS_FNB_EXITO no existe o fue borrado');
    END;
    dbms_output.put_line('Existe objeto(nuConta>0 paquete): '||nuConta);
    IF nuConta > 0 then
        EXECUTE IMMEDIATE 'DROP '||sbobject_type||' '||sbDueno||'.'||sbobject_name||'';
        dbms_output.put_Line(sbobject_type||' '||sbDueno||'.'||sbobject_name||' Borrado con exito!');
    END IF;
END;
/