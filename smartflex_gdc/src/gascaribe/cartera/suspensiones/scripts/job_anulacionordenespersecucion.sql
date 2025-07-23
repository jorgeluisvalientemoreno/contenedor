DECLARE

  nuConta        NUMBER;
  nuErrorCode    NUMBER;
  sbErrorMessage VARCHAR2(4000);

BEGIN
  
  dbms_output.put_Line('INICIO Programar JOB por DB');

  SELECT COUNT(*)
    INTO nuConta
    FROM DBA_SCHEDULER_JOBS
   WHERE JOB_NAME = 'ANULACIONORDENESPERSECUCION';

  IF (nuconta > 0) THEN
    dbms_scheduler.drop_job(job_name => 'ANULACIONORDENESPERSECUCION');
    dbms_output.put_Line('JOB ANULACIONORDENESPERSECUCION Procesando....');
  END IF;

  BEGIN
    Dbms_Scheduler.Create_Job(Job_Name        => 'ANULACIONORDENESPERSECUCION',
                              Job_Type        => 'PLSQL_BLOCK',
                              Job_Action      => 'Begin pkg_boPersecucion.prcAnulacionOrdenes; End;',
                              Start_Date      => NULL,
                              Repeat_Interval => 'FREQ=HOURLY',
                              End_Date        => NULL,
                              Comments        => 'Job para anular ordenes de persecucion por pago',
                              Enabled         => TRUE,
                              Auto_Drop       => FALSE);
							  
	dbms_output.put_Line('Job llamado ANULACIONORDENESPERSECUCION creado con exito');
  END;
  
  dbms_output.put_Line('FIN Programar JOB por DB');
  
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