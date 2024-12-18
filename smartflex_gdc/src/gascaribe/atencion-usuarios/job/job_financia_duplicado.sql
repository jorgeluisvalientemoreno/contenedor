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
   WHERE JOB_NAME = 'JOB_FINANCIA_DUPLICADO';

  IF nuconta = 0 THEN
  
    Begin
    
      DBMS_SCHEDULER.CREATE_JOB(job_name        => 'JOB_FINANCIA_DUPLICADO',
                                job_type        => 'PLSQL_BLOCK',
                                job_action      => 'BEGIN PRC_FINANCIA_DUPLICADO; END;',
                                start_date      => Systimestamp,
                                Repeat_Interval => 'freq=minutely; interval=15',
                                auto_drop       => FALSE,
                                enabled         => TRUE,
                                comments        => 'JOB DE FINANCIACION DE COBRO DE DUPLICADO DE FACTURA');
    
    End;
  
    dbms_output.put_Line(' Job JOB_FINANCIA_DUPLICADO creado con exito');
    commit;
  
  else
  
    dbms_output.put_Line('Ya existe el JOB DBMS_SCHEDULER llamado JOB_FINANCIA_DUPLICADO');
  
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
