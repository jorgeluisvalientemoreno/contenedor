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
    
    dbms_output.put_Line('JOB LDC_JOB_NUMERACION_VENTA Procesando....');
  IF nuconta > 0 THEN
    dbms_scheduler.drop_job(job_name => 'LDC_JOB_NUMERACION_VENTA');
    dbms_output.put_Line('JOB LDC_JOB_NUMERACION_VENTA Eliminado');
  ELSE 
    dbms_output.put_Line('JOB LDC_JOB_NUMERACION_VENTA no esta programado');
  end if;

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