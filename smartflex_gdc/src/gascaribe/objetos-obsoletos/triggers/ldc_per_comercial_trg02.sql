set serveroutput on size unlimited
set linesize 1000
set timing on

PROMPT =========================================
PROMPT **** Inicia borrado en entidad DBA_OBJECTS 
PROMPT Borrar Trigger LDC_PER_COMERCIAL_TRG02
PROMPT 
DECLARE
  nuConta       NUMBER;
  sbDueno	      VARCHAR2(30);
  sbobject_name	VARCHAR2(128);
  sbobject_type VARCHAR2(19);
BEGIN
    BEGIN
        SELECT COUNT(*), OWNER, OBJECT_NAME, OBJECT_TYPE INTO nuConta, sbDueno, sbobject_name, sbobject_type
          FROM dba_objects
         WHERE object_name = 'LDC_PER_COMERCIAL_TRG02'  
           AND OWNER = 'OPEN'
           AND OBJECT_TYPE <> 'SYNONYM'
         GROUP BY OWNER, OBJECT_NAME, OBJECT_TYPE; 
    EXCEPTION WHEN OTHERS THEN
        nuConta:= 0;
        dbms_output.put_Line(sbobject_type||' '||sbobject_name||' no existe o fue borrado');
    END;
  IF nuConta > 0 then
    EXECUTE IMMEDIATE 'DROP '||sbobject_type||' '||sbDueno||'.'||sbobject_name||'';
    dbms_output.put_Line('Trigger LDC_PER_COMERCIAL_TRG02 borrado con exito');
  END IF;
EXCEPTION
    WHEN OTHERS THEN 
        dbms_output.put_line('No se pudo borrar '||sbobject_name||', '||sqlerrm); 
END;
/

PROMPT **** Termina borrado en entidad DBA_OBJECTS**** 
PROMPT =========================================

set serveroutput off
/