set serveroutput on;
PROMPT BORRAR LDCFNU_VENANOACTUAL  
DECLARE
  nuConta       NUMBER;
  sbDueno	    VARCHAR2(30);
  sbobject_name	VARCHAR2(128);
  sbobject_type VARCHAR2(19);
BEGIN
    BEGIN
        SELECT COUNT(*), OWNER, OBJECT_NAME, OBJECT_TYPE INTO nuConta, sbDueno, sbobject_name, sbobject_type
          FROM dba_objects
         WHERE object_name = 'LDCFNU_VENANOACTUAL'  
           AND OWNER = 'ADM_PERSON'
           AND OBJECT_TYPE <> 'SYNONYM'
         GROUP BY OWNER, OBJECT_NAME, OBJECT_TYPE; 
    EXCEPTION WHEN OTHERS THEN
        nuConta:= 0;
        dbms_output.put_Line('ADM_PERSON.LDCFNU_VENANOACTUAL no existe o fue borrado');
    END;
  IF nuConta > 0 then
    EXECUTE IMMEDIATE 'DROP '||sbobject_type||' '||sbDueno||'.'||sbobject_name||'';
    dbms_output.put_Line(sbobject_type||' '||sbDueno||'.'||sbobject_name||' borrado con exito');
  END IF;
EXCEPTION
    WHEN OTHERS THEN 
        dbms_output.put_line('No se pudo borrar '||sbobject_name||', '||sqlerrm); 
END;
/