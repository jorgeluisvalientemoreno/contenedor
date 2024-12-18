SET SERVEROUTPUT ON;
PROMPT Borrado job 425323
/*Ejecuta: begin ldc_prregistraorden; end;*/
DECLARE

    nuexist NUMBER;
    nuJob NUMBER := 425323; 

BEGIN

    SELECT COUNT(*)
    INTO nuexist
    FROM dba_jobs
    WHERE job = 425323;
    
    IF nuexist > 0 THEN
        DBMS_JOB.REMOVE(nuJob);
    END IF;
    
    COMMIT;
    
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar la tabla '||nuJob||' - ' || sqlerrm);
END;
/