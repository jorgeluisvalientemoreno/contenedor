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
   WHERE JOB_NAME = 'LDC_JOBNOT_CXC_SIN_LEGALIZAR';

  IF nuconta > 0 THEN
    dbms_scheduler.drop_job(job_name => 'LDC_JOBNOT_CXC_SIN_LEGALIZAR');
    dbms_output.put_Line('JOB LDC_JOBNOT_CXC_SIN_LEGALIZAR Procesando....');
  end if;

  Begin
    Dbms_Scheduler.Create_Job(Job_Name        => 'LDC_JOBNOT_CXC_SIN_LEGALIZAR',
                              Job_Type        => 'PLSQL_BLOCK',
                              Job_Action      => 'Begin PERSONALIZACIONES.LDC_PRNOT_CXC_SIN_LEGALIZAR; End;',
                              Start_Date      => TIMESTAMP '2023-03-27 02:00:00',
                              Repeat_Interval => 'FREQ=WEEKLY',
                              End_Date        => Null,
                              Comments        => 'Job para notificar CXC No Legalizadas',
                              Enabled         => True,
                              Auto_Drop       => False);
  End;

  dbms_output.put_Line('Job llamado LDC_JOBNOT_CXC_SIN_LEGALIZAR creado con exito');
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
