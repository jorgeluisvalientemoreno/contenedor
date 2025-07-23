DECLARE

  nuConta        NUMBER;
  nuErrorCode    NUMBER;
  sbErrorMessage VARCHAR2(4000);

BEGIN
  
  dbms_output.put_Line('INICIO DesProgramacion JOB por DB');

  SELECT COUNT(*)
    INTO nuConta
    FROM DBA_SCHEDULER_JOBS
   WHERE JOB_NAME = 'LDC_ANULAR_ORDENES_PERSECU';

  IF (nuconta > 0) THEN
    dbms_scheduler.drop_job(job_name => 'LDC_ANULAR_ORDENES_PERSECU');
    dbms_output.put_Line('JOB LDC_ANULAR_ORDENES_PERSECU Procesando....');
  END IF;
   
  dbms_output.put_Line('FIN DesProgramamacion JOB por DB');
  
  COMMIT;

EXCEPTION
  WHEN OTHERS THEN
    Pkg_Error.SetError;
    Pkg_Error.GetError(nuErrorCode, sbErrorMessage);
    dbms_output.put_line('ERROR OTHERS ');
    dbms_output.put_line('error onuErrorCode: ' || nuErrorCode);
    dbms_output.put_line('error osbErrorMess: ' || sbErrorMessage);
    ROLLBACK;
END;
/