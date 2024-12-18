DECLARE
  nuConta NUMBER;
BEGIN
  SELECT COUNT(*)
    INTO nuconta
    FROM DBA_SCHEDULER_JOBS
   WHERE JOB_NAME = 'JOB_CUADRES_BOBEGAS';
   
  IF nuconta > 0 THEN
    dbms_scheduler.drop_job(job_name => 'JOB_CUADRES_BOBEGAS');
    dbms_output.put_Line('JOB JOB_CUADRES_BOBEGAS Procesando....');
  end if;
END;
/