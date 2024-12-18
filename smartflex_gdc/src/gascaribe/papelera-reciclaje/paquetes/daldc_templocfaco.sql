set serveroutput on;
PROMPT BORRAR DALDC_TEMPLOCFACO EN OPEN y SYNONYM PUBLIC EN OPEN
DECLARE
  nuConta       NUMBER;
  sbDueno	    VARCHAR2(30);
  sbobject_name	VARCHAR2(128);
  sbobject_type VARCHAR2(19);
BEGIN
    BEGIN
    dbms_output.put_Line('Preparando borrado de Sinónimo publico DALDC_TEMPLOCFACO');
      SELECT COUNT(*), OWNER, OBJECT_NAME,  OBJECT_TYPE INTO nuConta, sbDueno, sbobject_name, sbobject_type
      FROM dba_objects
      WHERE object_name = 'DALDC_TEMPLOCFACO'
       AND OWNER = 'PUBLIC'
       AND OBJECT_TYPE = 'SYNONYM'
       GROUP BY OWNER, OBJECT_NAME, OBJECT_TYPE;
    EXCEPTION
        WHEN OTHERS THEN 
        nuConta:= 0;
        dbms_output.put_Line('Sinónimo publico DALDC_TEMPLOCFACO no existe o fue borrado');
    END; 
       dbms_output.put_line('Existe objeto(nuConta>0) Sinónimo: '||nuConta);
    IF nuConta > 0 then
        EXECUTE IMMEDIATE 'DROP '||sbDueno||' '||sbobject_type||' '||sbobject_name||'';
        dbms_output.put_Line(sbobject_type||' '||sbDueno||' '||sbobject_name||' Borrado con exito!');
    END IF;
     
    
    BEGIN
    dbms_output.put_Line('Preparando borrado de paquete OPEN.DALDC_TEMPLOCFACO');
        SELECT COUNT(*), OWNER, OBJECT_NAME,  OBJECT_TYPE INTO nuConta, sbDueno, sbobject_name, sbobject_type
          FROM dba_objects
         WHERE object_name = 'DALDC_TEMPLOCFACO'  
           AND OWNER = 'OPEN'
           AND OBJECT_TYPE ='PACKAGE'
         GROUP BY OWNER, OBJECT_NAME, OBJECT_TYPE;
         
    EXCEPTION WHEN OTHERS THEN
        nuConta:= 0;
        dbms_output.put_Line('paquete OPEN.DALDC_TEMPLOCFACO no existe o fue borrado');
    END;
    dbms_output.put_line('Existe objeto(nuConta>0 paquete): '||nuConta);
    IF nuConta > 0 then
        EXECUTE IMMEDIATE 'DROP '||sbobject_type||' '||sbDueno||'.'||sbobject_name||'';
        dbms_output.put_Line(sbobject_type||' '||sbDueno||'.'||sbobject_name||' Borrado con exito!');
    END IF;
END;
/