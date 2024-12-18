set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

    /***********************************************************
    ELABORADO POR:  Adriana Vargas
    EMPRESA:        MVM Ingenieria de Software
    FECHA:          Abril 2024 
    JIRA:           OSF-2597    
    ***********************************************************/
    
PROMPT Inicia borrado en entidad DBA_JOBS
DECLARE

    ID_JOB         NUMBER;
    nuErrorCode    NUMBER;
    sbErrorMessage VARCHAR2(4000);

BEGIN
    BEGIN
      SELECT JOB 
        INTO ID_JOB
        FROM dba_jobs
       WHERE UPPER(what) = UPPER('BEGIN ProcGeneraasignacion1; END;');
    EXCEPTION WHEN OTHERS THEN
        ID_JOB:= 0;
        dbms_output.put_Line('Job PROCGENERAASIGNACION1 no existe o fue borrado');
    END;
    
    IF ID_JOB > 0 THEN
        dbms_job.remove(ID_JOB);
        dbms_output.put_Line('Job llamado PROCGENERAASIGNACION1 BORRADO con exito');
    END IF;  
    COMMIT;

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
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
/