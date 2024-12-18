set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');

    /***********************************************************
    ELABORADO POR:  Adriana Vargas
    EMPRESA:        MVM Ingenieria de Software
    FECHA:          Julio 2024 
    JIRA:           OSF-2964    
    ***********************************************************/
    
PROMPT Inicia borrado en entidad DBA_JOBS
DECLARE

    nuErrorCode     NUMBER;
    sbErrorMessage  VARCHAR2(4000);
    sbNombreJob     DBA_SCHEDULER_JOBS.Job_Name%TYPE;
    nuCant          NUMBER;
    
 CURSOR cu_Jobs is
    SELECT JOB_NAME
      FROM dba_scheduler_jobs
     WHERE JOB_NAME LIKE 'JOB_PRTSDWFINSTATTRIB2210211';
                                
BEGIN
    DBMS_OUTPUT.put_Line ('INICIO');
    DBMS_OUTPUT.put_Line ('-------------------------------------');
    BEGIN
    
    OPEN cu_Jobs;
    FETCH cu_Jobs INTO sbNombreJob;
    CLOSE cu_Jobs;    

    EXCEPTION WHEN OTHERS THEN 
        sbNombreJob:= NULL;
        dbms_output.put_Line('Job OPEN.JOB_PRTSDWFINSTATTRIB2210211 no existe o fue borrado');
    END; 
      
    IF sbNombreJob IS NOT NULL
    THEN
        dbms_output.put_line('-->Encontró: '||sbNombreJob); 
        DBMS_SCHEDULER.drop_job (job_name => sbNombreJob);
        DBMS_OUTPUT.put_Line ('-->Se hizo drop al JOB ' || sbNombreJob);
    
    ELSE
        dbms_output.put_Line('Job OPEN.JOB_PRTSDWFINSTATTRIB2210211 no existe o fue borrado');
    END IF;

    DBMS_OUTPUT.put_Line ('-------------------------------------');
    DBMS_OUTPUT.put_Line ('FIN');
EXCEPTION
  WHEN OTHERS THEN
    Errors.setError;
    Errors.getError(nuErrorCode, sbErrorMessage);
    dbms_output.put_line('ERROR OTHERS ');
    dbms_output.put_line('error onuErrorCode: ' || nuErrorCode);
    dbms_output.put_line('error osbErrorMess: ' || sbErrorMessage);
    ROLLBACK;
  
END;
/
