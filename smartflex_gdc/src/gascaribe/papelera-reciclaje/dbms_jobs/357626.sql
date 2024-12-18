DECLARE

    nuJobAntes  NUMBER;
    nuJob       NUMBER := 357626;
    
    CURSOR cuDBA_Jobs
    IS
    SELECT job
    FROM DBA_Jobs
    WHERE job = nuJob;

BEGIN

    OPEN cuDBA_Jobs;
    FETCH cuDBA_Jobs INTO nuJobAntes;
    CLOSE cuDBA_Jobs;
    
    IF NVL(nuJobAntes,-1) = nuJob THEN
    
        BEGIN
        
            DBMS_JOB.REMOVE(nuJob);
            COMMIT;
            dbms_output.put_line('INFO: Se borró el Job ' || nuJob );
            EXCEPTION
                WHEN OTHERS THEN
                dbms_output.put_line('ERROR: al borrar el Job ' || nuJob || '|' || sqlerrm );
                ROLLBACK;
        END;
        
    ELSE    
        dbms_output.put_line('INFO: No existe el Job ' || nuJob );    
    END IF;
                
END;
/