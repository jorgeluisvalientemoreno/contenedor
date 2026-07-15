--Ejecutar en SFPL. Imprime en el OUTPUT, el script a versionar.
DECLARE
    sbNombreJob       dba_scheduler_jobs.job_name%TYPE := UPPER('LDC_JOBNOT_CXC_SIN_LEGALIZAR');
    sbOwner           dba_scheduler_jobs.owner%TYPE := UPPER('OPEN');
    clInstruccion     CLOB;
  
    CURSOR cuJobs
    (
        isbNombreJob    IN dba_scheduler_jobs.job_name%TYPE,
        isbOwner        IN dba_scheduler_jobs.owner%TYPE
    ) IS
        SELECT  *
        FROM    dba_scheduler_jobs
        WHERE   job_name = isbNombreJob
        AND     owner = isbOwner;

    TYPE tytbJobs IS TABLE OF cuJobs%ROWTYPE INDEX BY BINARY_INTEGER;
    tbJobs      tytbJobs;
    nuIndex     BINARY_INTEGER;
BEGIN
  
    OPEN cuJobs(sbNombreJob, sbOwner);
    FETCH cuJobs BULK COLLECT INTO tbJobs;
    CLOSE cuJobs;
    
    nuIndex := tbJobs.FIRST;
        
    LOOP
        EXIT WHEN nuIndex IS NULL;
        
        clInstruccion := 'BEGIN' || CHR(10) ||
             '  DBMS_SCHEDULER.CREATE_JOB (' || CHR(10) ||
             '    job_name        => ''' || tbJobs(nuIndex).owner||'.'||tbJobs(nuIndex).job_name || ''',' || CHR(10) ||
             '    job_type        => ''' || tbJobs(nuIndex).job_type || ''',' || CHR(10) ||
             '    job_action      => ''' || tbJobs(nuIndex).job_action || ''' ,' || CHR(10)||
             '    number_of_arguments => ' || tbJobs(nuIndex).number_of_arguments || ',' || CHR(10);
             
        IF (tbJobs(nuIndex).start_date IS NOT NULL) THEN
            clInstruccion := clInstruccion || '    start_date      => TO_TIMESTAMP(''' || TO_CHAR(tbJobs(nuIndex).start_date, 'YYYY-MM-DD HH24:MI:SS') || ''', ''YYYY-MM-DD HH24:MI:SS''),' || CHR(10);
        END IF;
    
        IF (tbJobs(nuIndex).repeat_interval IS NOT NULL) THEN
            clInstruccion := clInstruccion || '    repeat_interval => ''' || tbJobs(nuIndex).repeat_interval || ''' ,' || CHR(10);
        END IF;
    
        IF (tbJobs(nuIndex).end_date IS NOT NULL) THEN
            clInstruccion := clInstruccion || '    end_date        => TO_TIMESTAMP(''' || TO_CHAR(tbJobs(nuIndex).end_date, 'YYYY-MM-DD HH24:MI:SS') || ''', ''YYYY-MM-DD HH24:MI:SS''),' || CHR(10);
        END IF;
    
        IF (tbJobs(nuIndex).comments IS NOT NULL) THEN
            clInstruccion := clInstruccion || '    comments        => ''' || tbJobs(nuIndex).comments || ''',' || CHR(10);
        END IF;
    
        clInstruccion := clInstruccion ||
                 '    enabled         => FALSE,' || CHR(10) ||
                 '    auto_drop       => ' || tbJobs(nuIndex).auto_drop || '' || CHR(10) ||
                 '  );' || CHR(10) || CHR(10) ||
                 '  DBMS_SCHEDULER.ENABLE('''||sbOwner||'.'||sbNombreJob||''');'|| CHR(10) ||
                 'END;' || CHR(10) || '/';
    
        DBMS_OUTPUT.PUT_LINE(clInstruccion);
        
        nuIndex := tbJobs.NEXT(nuIndex);
    END LOOP;
END;
/