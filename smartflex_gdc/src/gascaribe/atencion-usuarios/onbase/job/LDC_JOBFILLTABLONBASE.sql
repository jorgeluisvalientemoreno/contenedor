DECLARE

  nuconta        NUMBER;
  nuErrorCode    NUMBER;
  sbErrorMessage VARCHAR2(4000);

BEGIN

  dbms_output.put_Line('INICIO');
  dbms_output.put_Line('-------------------------------------');

  SELECT COUNT(*)
    INTO nuconta
    FROM DBA_SCHEDULER_JOBS
   WHERE JOB_NAME = 'LDC_JOBFILLTABLONBASE';

  IF nuconta = 0 THEN
  
    Begin
    
      DBMS_SCHEDULER.CREATE_JOB(job_name        => 'LDC_JOBFILLTABLONBASE',
                                job_type        => 'PLSQL_BLOCK',
                                job_action      => 'BEGIN LDC_PRFILLTABLONBASE; END;',
                                start_date      => SYSDATE,
                                repeat_interval => 'SYSDATE+30/1440',
                                auto_drop       => FALSE,
                                enabled         => TRUE,
                                comments        => 'Job que inicia el proceso de LDC_PRFILLTABLONBASE cada 30 minutos');
    
    End;
  
    dbms_output.put_Line(' Job LDC_JOBFILLTABLONBASE creado con exito');
    commit;
  
  else
  
    dbms_output.put_Line('Creacion del JOB LDC_JOBFILLTABLONBASE');
  
    BEGIN
    
      DBMS_SCHEDULER.DROP_JOB(job_name => 'LDC_JOBFILLTABLONBASE');
    
    END;
  
    Begin
    
      DBMS_SCHEDULER.CREATE_JOB(job_name        => 'LDC_JOBFILLTABLONBASE',
                                job_type        => 'PLSQL_BLOCK',
                                job_action      => 'BEGIN LDC_PRFILLTABLONBASE; END;',
                                start_date      => SYSDATE,
                                repeat_interval => 'SYSDATE+30/1440',
                                auto_drop       => FALSE,
                                enabled         => TRUE,
                                comments        => 'Job que inicia el proceso de LDC_PRFILLTABLONBASE cada 30 minutos');
    
    End;
  
    dbms_output.put_Line(' Job LDC_JOBFILLTABLONBASE creado con exito');
    commit;
  
  END IF;

  dbms_output.put_Line('-------------------------------------');
  dbms_output.put_Line('FIN');

EXCEPTION

  when ex.CONTROLLED_ERROR then
    Errors.getError(nuErrorCode, sbErrorMessage);
    dbms_output.put_line('ERROR CONTROLLED ');
    dbms_output.put_line('error onuErrorCode: ' || nuErrorCode);
    dbms_output.put_line('error osbErrorMess: ' || sbErrorMessage);
  
    rollback;
  
  when OTHERS then
  
    Errors.setError;
    Errors.getError(nuErrorCode, sbErrorMessage);
    dbms_output.put_line('ERROR OTHERS ');
    dbms_output.put_line('error onuErrorCode: ' || nuErrorCode);
    dbms_output.put_line('error osbErrorMess: ' || sbErrorMessage);
  
    rollback;
  
END;

/
