declare

    sbJob_Name      VARCHAR2(30) := 'CARTERA_LINEA_GDC';

    CURSOR cuDBA_SCHEDULER_JOBS
    IS
    SELECT *
    FROM DBA_SCHEDULER_JOBS
    WHERE job_name = sbJob_Name;
    
    rcDBA_SCHEDULER_JOBS    cuDBA_SCHEDULER_JOBS%ROWTYPE;
    
begin
    
    OPEN cuDBA_SCHEDULER_JOBS;
    FETCH cuDBA_SCHEDULER_JOBS INTO rcDBA_SCHEDULER_JOBS;
    CLOSE cuDBA_SCHEDULER_JOBS;

    IF rcDBA_SCHEDULER_JOBS.JOB_NAME IS NOT NULL THEN
    
        dbms_output.put_line( 'Inicia Borrado Job ' || sbJob_Name );
        dbms_Scheduler.drop_job( job_name => sbJob_Name , force => true );  
        COMMIT;
        dbms_output.put_line( 'Fin Borrado Job ' || sbJob_Name );
        
    ELSE
    
        dbms_output.put_line( 'No existe el Job ' || sbJob_Name );
            
    END IF;       
    EXCEPTION
        WHEN OTHERS THEN
            dbms_output.put_line( 'Error Borrando Job ' || sbJob_Name || '|' || sqlerrm ); 
            ROLLBACK;              
end;
/