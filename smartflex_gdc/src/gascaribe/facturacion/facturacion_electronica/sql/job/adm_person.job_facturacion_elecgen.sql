DECLARE
   nuConta NUMBER;
  
BEGIN
  
  SELECT COUNT(1) INTO nuConta
  FROM dba_scheduler_jobs
  WHERE job_name = 'JOB_FACTURACION_ELECGEN'
   AND owner = 'ADM_PERSON';
   
  IF nuConta = 0 THEN 
      DBMS_SCHEDULER.create_job (
        job_name        => 'ADM_PERSON.JOB_FACTURACION_ELECGEN',
        job_type        => 'PLSQL_BLOCK',
        job_action      => 'BEGIN pkg_UtilFacturacionElecGen.prCrearProcMasivo; END;',
        start_date      => SYSTIMESTAMP,
        repeat_interval => 'freq=hourly; interval=1',
        enabled         => TRUE,
        auto_drop      => FALSE);
  END IF;
END;
/