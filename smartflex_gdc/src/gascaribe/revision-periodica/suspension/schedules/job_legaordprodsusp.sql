REM Fuente="Propiedad Intelectual de Gases del Caribe"
REM Script		 :		job_legaordprodsusp.sql
REM Autor 		 :		Lubin Pineda - MVM
REM Fecha 		 :		23-01-2021
REM Descripcion	 :		Crea el job JOB_LEGAORDPRODSUSP
REM Tarea		 :		OSF-814
DECLARE

    nuErrorCode      NUMBER;
    sbErrorMessage   VARCHAR2 (4000);

    sbNombreJob      DBA_SCHEDULER_JOBS.Job_Name%TYPE;

    CURSOR cuDBA_SCHEDULER_JOBS IS
        SELECT job_name
          FROM DBA_SCHEDULER_JOBS
         WHERE JOB_NAME LIKE 'JOB_LEGAORDPRODSUSP';
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

    sbNombreJob := 'JOB_LEGAORDPRODSUSP';
    
    BEGIN
        DBMS_SCHEDULER.Create_Job (
            Job_Name          => sbNombreJob,
            Job_Type          => 'PLSQL_BLOCK',
            Job_Action        =>
                'LDC_BO_GESTIONSUSPSEG.Ldc_job_LegOrdProdYaSusp();',
            Start_Date        => TRUNC (SYSDATE),
            Repeat_Interval   => 'FREQ=DAILY;BYHOUR=1',
            End_Date          => NULL,
            Comments          =>
                'Legaliza ordenes del tipo de trabajo 10966',
            Enabled           => TRUE,
            Auto_Drop         => FALSE);
    END;

    DBMS_OUTPUT.put_Line (
        'Job llamado ' || sbNombreJob || ' creado con exito');
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