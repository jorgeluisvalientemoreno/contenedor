set serveroutput on;
PROMPT BORRAR synonym LDC_OS_UDPREQUESTADDRESS EN GISOSF y crearlo para ADM_PERSON
DECLARE
  nuConta       NUMBER;
  sbDueno	    VARCHAR2(30);
  sbobject_name	VARCHAR2(128);
  sbobject_type VARCHAR2(19);
BEGIN
    BEGIN
      SELECT COUNT(*) INTO nuConta
        FROM ALL_SYNONYMS
       WHERE SYNONYM_NAME = 'LDC_OS_UDPREQUESTADDRESS'
         AND OWNER = 'GISOSF' ;
    EXCEPTION WHEN OTHERS THEN
        nuConta:= 0;
        dbms_output.put_Line('GISOSF.LDC_OS_UDPREQUESTADDRESS para OPEN no existe o fue borrado');
    END;
       dbms_output.put_line('nuConta '||nuConta);
      IF nuConta > 0 THEN        
		EXECUTE IMMEDIATE 'DROP SYNONYM GISOSF.LDC_OS_UDPREQUESTADDRESS';
        dbms_output.put_line('SYNONYM GISOSF.LDC_OS_UDPREQUESTADDRESS Borrado para OPEN');
      END IF;
--
    BEGIN
      SELECT COUNT(*), OWNER, OBJECT_NAME, OBJECT_TYPE INTO nuConta, sbDueno, sbobject_name, sbobject_type
        FROM dba_objects
       WHERE object_name = 'LDC_OS_UDPREQUESTADDRESS'
         AND OWNER = 'GISOSF'
         AND OBJECT_TYPE = 'SYNONYM';
    EXCEPTION WHEN OTHERS THEN
        nuConta:= 0;
        dbms_output.put_Line('GISOSF.LDC_OS_UDPREQUESTADDRESS para ADM_PERSON no existe o fue borrado');
    END;
       dbms_output.put_line('nuConta '||nuConta);
      IF nuConta = 0 THEN        
        EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM GISOSF.LDC_OS_UDPREQUESTADDRESS FOR ADM_PERSON.LDC_OS_UDPREQUESTADDRESS';
        dbms_output.put_line('SYNONYM GISOSF.LDC_OS_UDPREQUESTADDRESS Creado para ADM_PERSON ');
      END IF; 
      
EXCEPTION
    WHEN OTHERS THEN 
        dbms_output.put_line('Error: LDC_OS_UDPREQUESTADDRESS , '||sqlerrm); 
 
END;
/