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
   WHERE JOB_NAME = 'JOB_AGRUPAOTTITR';

  IF nuconta > 0 THEN
    dbms_scheduler.drop_job(job_name => 'JOB_AGRUPAOTTITR');
    dbms_output.put_Line('JOB JOB_AGRUPAOTTITR Procesando....');
  end if;

  Begin
    Dbms_Scheduler.Create_Job(Job_Name        => 'JOB_AGRUPAOTTITR',
                              Job_Type        => 'PLSQL_BLOCK',
                              Job_Action      => 'declare inucontractypeid number; inucontractor number; Begin pkErrors.SetApplication(' || '''' ||  'JOBAGPTT'|| '''' || ' ); ct_boliquidationsupport.grouporderbyday(inucontractypeid, inucontractor ); pkg_boordenes_industriales.prcReValorizacionAgrupadoras; End;',
                              Start_Date      => to_date('09/09/2022 01:00:00','dd/mm/yyyy hh24:mi:ss'),
                              Repeat_Interval => 'FREQ=DAILY;INTERVAL=1',
                              End_Date        => Null,
                              Comments        => 'Agrupacion de ordenes de trabajo por tipo de trabajo',
                              Enabled         => True,
                              Auto_Drop       => False);
  End;

  dbms_output.put_Line('Job llamado JOB_AGRUPAOTTITR creado con exito');
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
