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
   WHERE JOB_NAME = 'LDC_JOB_NUMERACION_VENTA';

  IF nuconta > 0 THEN
    dbms_scheduler.drop_job(job_name => 'LDC_JOB_NUMERACION_VENTA');
    dbms_output.put_Line('JOB LDC_JOB_NUMERACION_VENTA Procesando....');
  end if;

  Begin
    Dbms_Scheduler.Create_Job(Job_Name        => 'LDC_JOB_NUMERACION_VENTA',
                              Job_Type        => 'PLSQL_BLOCK',
                              Job_Action      => 'Begin LDC_JOB_FLUJO_NUMERACION_VENTA; End;',
                              Start_Date      => Systimestamp,
                              Repeat_Interval => 'freq=minutely; interval=10',
                              End_Date        => Null,
                              Comments        => 'Proceso para corregir numeracion de venta de gas',
                              Enabled         => True,
                              Auto_Drop       => False);
  End;

  dbms_output.put_Line('Job llamado LDC_JOB_NUMERACION_VENTA creado con exito');
  commit;

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
