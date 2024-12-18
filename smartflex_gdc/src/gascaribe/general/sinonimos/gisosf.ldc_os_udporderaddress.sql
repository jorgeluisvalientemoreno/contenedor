set serveroutput on;
PROMPT BORRAR synonym LDC_OS_UDPORDERADDRESS EN GISOSF y crearlo para ADM_PERSON
DECLARE
  nuConta       NUMBER;
  sbDueno	    VARCHAR2(30);
  sbobject_name	VARCHAR2(128);
  sbobject_type VARCHAR2(19);
BEGIN
    BEGIN
      SELECT COUNT(*), OWNER, OBJECT_NAME, OBJECT_TYPE INTO nuConta, sbDueno, sbobject_name, sbobject_type
        FROM dba_objects
       WHERE object_name = 'LDC_OS_UDPORDERADDRESS'
         AND OWNER = 'GISOSF'
         AND OBJECT_TYPE = 'SYNONYM'
         GROUP BY OWNER, OBJECT_NAME, OBJECT_TYPE;
    EXCEPTION WHEN OTHERS THEN
        nuConta:= 0;
        dbms_output.put_Line('GISOSF.LDC_OS_UDPORDERADDRESS para OPEN no existe o fue borrado');
    END;
       dbms_output.put_line('nuConta '||nuConta);
      IF nuConta > 0 THEN        
		EXECUTE IMMEDIATE 'DROP SYNONYM GISOSF.LDC_OS_UDPORDERADDRESS';
        dbms_output.put_line('SYNONYM GISOSF.LDC_OS_UDPORDERADDRESS Borrado para OPEN');
      END IF;
--
    BEGIN
      SELECT COUNT(*), OWNER, OBJECT_NAME, OBJECT_TYPE INTO nuConta, sbDueno, sbobject_name, sbobject_type
        FROM dba_objects
       WHERE object_name = 'LDC_OS_UDPORDERADDRESS'
         AND OWNER = 'GISOSF'
         AND OBJECT_TYPE = 'SYNONYM'
         GROUP BY OWNER, OBJECT_NAME, OBJECT_TYPE;
    EXCEPTION WHEN OTHERS THEN
        nuConta:= 0;
        dbms_output.put_Line('GISOSF.LDC_OS_UDPORDERADDRESS para ADM_PERSON no existe o fue borrado');
    END;
       dbms_output.put_line('nuConta '||nuConta);
      IF nuConta = 0 THEN        
        EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM GISOSF.LDC_OS_UDPORDERADDRESS FOR ADM_PERSON.LDC_OS_UDPORDERADDRESS';
        dbms_output.put_line('SYNONYM GISOSF.LDC_OS_UDPORDERADDRESS Creado para ADM_PERSON ');
      END IF; 
      
EXCEPTION
    WHEN OTHERS THEN 
        dbms_output.put_line('Error: LDC_OS_UDPORDERADDRESS , '||sqlerrm); 
 
END;
/