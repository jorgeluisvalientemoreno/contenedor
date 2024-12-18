set serveroutput on;
PROMPT BORRAR synonym LDC_PRLECTURAVAL EN INNOVACION y crearlo para ADM_PERSON
DECLARE
  nuConta       NUMBER;
  sbDueno	    VARCHAR2(30);
  sbobject_name	VARCHAR2(128);
  sbobject_type VARCHAR2(19);
BEGIN
    BEGIN
      SELECT COUNT(*), OWNER, OBJECT_NAME, OBJECT_TYPE INTO nuConta, sbDueno, sbobject_name, sbobject_type
        FROM dba_objects
       WHERE object_name = 'LDC_PRLECTURAVAL'
         AND OWNER = 'INNOVACION'
         AND OBJECT_TYPE = 'SYNONYM'
         GROUP BY OWNER, OBJECT_NAME, OBJECT_TYPE;
    EXCEPTION WHEN OTHERS THEN
        nuConta:= 0;
        dbms_output.put_Line('INNOVACION.LDC_PRLECTURAVAL para OPEN no existe o fue borrado');
    END;
       dbms_output.put_line('nuConta '||nuConta);
      IF nuConta > 0 THEN        
		EXECUTE IMMEDIATE 'DROP SYNONYM INNOVACION.LDC_PRLECTURAVAL';
        dbms_output.put_line('SYNONYM INNOVACION.LDC_PRLECTURAVAL Borrado para OPEN');
      END IF;
--
    BEGIN
      SELECT COUNT(*), OWNER, OBJECT_NAME, OBJECT_TYPE INTO nuConta, sbDueno, sbobject_name, sbobject_type
        FROM dba_objects
       WHERE object_name = 'LDC_PRLECTURAVAL'
         AND OWNER = 'INNOVACION'
         AND OBJECT_TYPE = 'SYNONYM'
         GROUP BY OWNER, OBJECT_NAME, OBJECT_TYPE;
    EXCEPTION WHEN OTHERS THEN
        nuConta:= 0;
        dbms_output.put_Line('INNOVACION.LDC_PRLECTURAVAL para ADM_PERSON no existe o fue borrado');
    END;
       dbms_output.put_line('nuConta '||nuConta);
      IF nuConta = 0 THEN        
        EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM INNOVACION.LDC_PRLECTURAVAL FOR ADM_PERSON.LDC_PRLECTURAVAL';
        dbms_output.put_line('SYNONYM INNOVACION.LDC_PRLECTURAVAL Creado para ADM_PERSON ');
      END IF; 
      
EXCEPTION
    WHEN OTHERS THEN 
        dbms_output.put_line('Error: LDC_PRLECTURAVAL , '||sqlerrm); 
 
END;
/