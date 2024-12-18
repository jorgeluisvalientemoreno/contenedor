set serveroutput on;
PROMPT BORRAR LDC_PROCCREASOLICITUDSUSPADMIN
DECLARE
  nuConta       NUMBER;
  sbDueno	    VARCHAR2(30);
  sbobject_name	VARCHAR2(128);
  sbobject_type VARCHAR2(19);
  nuCantidad      NUMBER;     
  nuCant          NUMBER;
  
  CURSOR Cu_reg
  IS
  SELECT COUNT(*) CANT, OWNER, OBJECT_NAME, OBJECT_TYPE
    FROM dba_objects
   WHERE object_name = 'LDC_PROCCREASOLICITUDSUSPADMIN'  
     AND OWNER != 'OPEN'
     AND OBJECT_TYPE ='SYNONYM' 
     GROUP BY OWNER, OBJECT_NAME, OBJECT_TYPE;  
BEGIN
    BEGIN
    dbms_output.put_Line('Preparando borrado de PROCEDURE OPEN.LDC_PROCCREASOLICITUDSUSPADMIN');
        SELECT COUNT(*), OWNER, OBJECT_NAME,  OBJECT_TYPE INTO nuConta, sbDueno, sbobject_name, sbobject_type
          FROM dba_objects
         WHERE object_name = 'LDC_PROCCREASOLICITUDSUSPADMIN'  
           AND OWNER = 'OPEN'
           AND OBJECT_TYPE ='PROCEDURE'
         GROUP BY OWNER, OBJECT_NAME, OBJECT_TYPE;
         
    EXCEPTION WHEN OTHERS THEN
        nuConta:= 0;
        dbms_output.put_Line('PROCEDURE OPEN.LDC_PROCCREASOLICITUDSUSPADMIN no existe o fue borrado');
    END;
    dbms_output.put_line('Existe objeto(nuConta>0): '||nuConta);
    IF nuConta > 0 then
        EXECUTE IMMEDIATE 'DROP '||sbobject_type||' '||sbDueno||'.'||sbobject_name||'';
        dbms_output.put_Line(sbobject_type||' '||sbDueno||'.'||sbobject_name||' Borrado con exito!');
    END IF;
    --

    BEGIN
    SELECT COUNT(1) INTO nuCantidad
      FROM dba_objects
     WHERE object_name = 'LDC_PROCCREASOLICITUDSUSPADMIN'  
       AND OWNER != 'OPEN'
       AND OBJECT_TYPE ='SYNONYM' ;

    EXCEPTION WHEN OTHERS THEN 
        nuCantidad:= 0;
    END;
      dbms_output.put_line('Encontró(>0): '||nuCantidad); 
      nuCant:= 0;
      IF nuCantidad > 0 THEN        
        dbms_output.put_line('RESULTADO:'); 
        nuCant:= 1;
        FOR reg IN Cu_reg LOOP  
            dbms_output.put_line('--> '||nuCant||'.-'||reg.OWNER||'|'||reg.OBJECT_NAME||'|'||reg.OBJECT_TYPE);
            IF reg.CANT > 0 THEN 
            sbDueno         := reg.OWNER;
            sbobject_type   := reg.OBJECT_TYPE;
            sbobject_name   := reg.OBJECT_NAME;
                EXECUTE IMMEDIATE 'DROP '||sbobject_type||' '||sbDueno||'.'||sbobject_name||'';
                dbms_output.put_Line(sbobject_type||' '||sbDueno||'.'||sbobject_name||' Borrado con exito!');
                dbms_output.put_Line('--------------------------------------------------');
            END IF;  
            COMMIT;
            nuCant:= nuCant+1;
        END LOOP;
      END IF; 
      
EXCEPTION
    WHEN OTHERS THEN 
        dbms_output.put_line('No se pudo borrar '||sbobject_type||' '||sbobject_name||', '||sqlerrm);  
END;
/