SET SERVEROUTPUT ON;
PROMPT Borrado tabla LDC_DETREPBR
Declare
    nuExist NUMBER;
    sbTabla VARCHAR2(50) := 'LDC_DETREPBR';
begin
    
    select COUNT(*)
    INTO nuExist
    from dba_all_tables
    where table_name = sbTabla;
    
    IF nuexist > 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE '||sbTabla;
    END IF;  
    
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar la tabla '||sbTabla||' - ' || sqlerrm);
END;
/
