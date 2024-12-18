DECLARE
  nuConta NUMBER;
BEGIN
  SELECT COUNT(*)
    INTO nuconta
    FROM DBA_SCHEDULER_JOBS
   WHERE JOB_NAME = 'TEMP_INFO';
   
  IF nuconta > 0 THEN
    dbms_scheduler.drop_job(job_name => 'TEMP_INFO');
    dbms_output.put_Line('JOB TEMP_INFO Procesando....');
  end if;
END;
/
