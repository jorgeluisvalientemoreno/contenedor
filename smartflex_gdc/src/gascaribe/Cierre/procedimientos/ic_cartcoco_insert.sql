DECLARE
    nuErrorCode      NUMBER;
    sbErrorMessage   VARCHAR2 (4000);
    sbNombreJob      DBA_SCHEDULER_JOBS.Job_Name%TYPE;
    CURSOR cuDBA_SCHEDULER_JOBS IS
        SELECT job_name
          FROM DBA_SCHEDULER_JOBS
         WHERE JOB_NAME LIKE 'JOB_INSERTIC_CARTCOCO';
BEGIN
    DBMS_OUTPUT.put_Line ('INICIO');
    DBMS_OUTPUT.put_Line ('-------------------------------------');
    OPEN cuDBA_SCHEDULER_JOBS;
    FETCH cuDBA_SCHEDULER_JOBS INTO sbNombreJob;
    CLOSE cuDBA_SCHEDULER_JOBS;
    IF sbNombreJob IS NOT NULL
    THEN
        DBMS_SCHEDULER.drop_job (job_name => sbNombreJob);
        DBMS_OUTPUT.put_Line ('Se hizo drop al JOB ' || sbNombreJob);
    END IF;
    sbNombreJob := 'JOB_INSERTIC_CARTCOCO';
    DBMS_OUTPUT.put_Line ('Start_Date|' || SYSDATE );
    DBMS_OUTPUT.put_Line ('systimestamp|' || systimestamp);
    BEGIN
        DBMS_SCHEDULER.Create_Job (
            Job_Name          => sbNombreJob,
            Job_Type          => 'PLSQL_BLOCK',
            Job_Action        => q'#BEGIN INSERT INTO OPEN.IC_CARTCOCO ( select * from open.IC_CARTCOCO_NEW ); COMMIT; END;#', 
            Start_Date        => systimestamp,
            End_Date          => NULL,
            Comments          => 'Inserta tabla IC_CARTCOCO',
            Enabled           => TRUE,
            Auto_Drop         => FALSE);
    END;
    DBMS_OUTPUT.put_Line ( 'Job llamado ' || sbNombreJob || ' creado con exito');
    COMMIT;
    DBMS_OUTPUT.put_Line ('-------------------------------------');
    DBMS_OUTPUT.put_Line ('FIN');
EXCEPTION
    WHEN ex.CONTROLLED_ERROR
    THEN
        Errors.getError (nuErrorCode, sbErrorMessage);
        DBMS_OUTPUT.put_line ('ERROR CONTROLLED ');
        DBMS_OUTPUT.put_line ('error onuErrorCode: ' || nuErrorCode);
        DBMS_OUTPUT.put_line ('error osbErrorMess: ' || sbErrorMessage);
        ROLLBACK;
    WHEN OTHERS
    THEN
        Errors.setError;
        Errors.getError (nuErrorCode, sbErrorMessage);
        DBMS_OUTPUT.put_line ('ERROR OTHERS ');
        DBMS_OUTPUT.put_line ('error onuErrorCode: ' || nuErrorCode);
        DBMS_OUTPUT.put_line ('error osbErrorMess: ' || sbErrorMessage);
        ROLLBACK;
END;
/