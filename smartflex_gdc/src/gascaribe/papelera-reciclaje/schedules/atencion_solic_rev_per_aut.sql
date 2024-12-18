DECLARE
  nuConta NUMBER;
BEGIN
  SELECT COUNT(*)
    INTO nuconta
    FROM DBA_SCHEDULER_JOBS
   WHERE JOB_NAME = 'ATENCION_SOLIC_REV_PER_AUT';
   
  IF nuconta > 0 THEN
    dbms_scheduler.drop_job(job_name => 'ATENCION_SOLIC_REV_PER_AUT');
    dbms_output.put_Line('JOB ATENCION_SOLIC_REV_PER_AUT Procesando....');
  end if;
END;
/