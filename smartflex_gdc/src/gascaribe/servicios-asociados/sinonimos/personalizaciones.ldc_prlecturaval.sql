set serveroutput on;
PROMPT BORRAR synonym LDC_PRLECTURAVAL EN PERSONALIZACIONES y crearlo para ADM_PERSON
DECLARE
  nuConta       NUMBER;
  sbDueno	    VARCHAR2(30);
  sbobject_name	VARCHAR2(128);
  sbobject_type VARCHAR2(19);
BEGIN
    BEGIN
      SELECT COUNT(*) INTO nuConta
        FROM ALL_SYNONYMS
       WHERE SYNONYM_NAME = 'LDC_PRLECTURAVAL'
         AND OWNER = 'PERSONALIZACIONES' ;
    EXCEPTION WHEN OTHERS THEN
        nuConta:= 0;
        dbms_output.put_Line('PERSONALIZACIONES.LDC_PRLECTURAVAL para OPEN no existe o fue borrado');
    END;
       dbms_output.put_line('nuConta '||nuConta);
      IF nuConta > 0 THEN        
		EXECUTE IMMEDIATE 'DROP SYNONYM PERSONALIZACIONES.LDC_PRLECTURAVAL';
        dbms_output.put_line('SYNONYM PERSONALIZACIONES.LDC_PRLECTURAVAL Borrado para OPEN');
      END IF;
--
    BEGIN
      SELECT COUNT(*), OWNER, OBJECT_NAME, OBJECT_TYPE INTO nuConta, sbDueno, sbobject_name, sbobject_type
        FROM dba_objects
       WHERE object_name = 'LDC_PRLECTURAVAL'
         AND OWNER = 'PERSONALIZACIONES'
         AND OBJECT_TYPE = 'SYNONYM';
    EXCEPTION WHEN OTHERS THEN
        nuConta:= 0;
        dbms_output.put_Line('PERSONALIZACIONES.LDC_PRLECTURAVAL para ADM_PERSON no existe o fue borrado');
    END;
       dbms_output.put_line('nuConta '||nuConta);
      IF nuConta = 0 THEN        
        EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM PERSONALIZACIONES.LDC_PRLECTURAVAL FOR ADM_PERSON.LDC_PRLECTURAVAL';
        dbms_output.put_line('SYNONYM PERSONALIZACIONES.LDC_PRLECTURAVAL Creado para ADM_PERSON ');
      END IF; 
      
EXCEPTION
    WHEN OTHERS THEN 
        dbms_output.put_line('Error: LDC_PRLECTURAVAL , '||sqlerrm); 
 
END;
/