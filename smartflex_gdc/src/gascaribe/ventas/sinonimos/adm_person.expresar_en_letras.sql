set serveroutput on;
PROMPT Crea Sinonimo a Paquete EXPRESAR_EN_LETRAS 
DECLARE
  nuConta       NUMBER;
  sbDueno	    VARCHAR2(30);
  sbobject_name	VARCHAR2(128);
  sbobject_type VARCHAR2(19);
BEGIN
    BEGIN
    dbms_output.put_Line('***Preparando borrado de synonym ADM_PERSON.EXPRESAR_EN_LETRAS');
        SELECT  COUNT(*), OWNER, OBJECT_NAME, OBJECT_TYPE INTO nuConta, sbDueno, sbobject_name, sbobject_type
          FROM dba_objects
         WHERE object_name = 'EXPRESAR_EN_LETRAS'
           AND OWNER = 'ADM_PERSON'
           AND OBJECT_TYPE = 'PACKAGE'
           GROUP BY OWNER, OBJECT_NAME, OBJECT_TYPE;
        dbms_output.put_line('Existe PACKAGE EXPRESAR_EN_LETRAS en ADM_PERSON(>0): '||nuConta);
    EXCEPTION WHEN OTHERS THEN
        nuConta:= 0;
        dbms_output.put_Line('PACKAGE EXPRESAR_EN_LETRAS no existe en ADM_PERSON');
    END;
    IF nuConta = 0 THEN
        EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.EXPRESAR_EN_LETRAS FOR EXPRESAR_EN_LETRAS';
        dbms_output.put_line( sbobject_type||' '||sbDueno||'.'||sbobject_name||' CREADO! ');
    END IF;

    
END;
/