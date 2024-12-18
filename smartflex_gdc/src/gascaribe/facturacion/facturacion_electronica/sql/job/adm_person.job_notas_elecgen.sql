DECLARE
   nuConta NUMBER;
BEGIN
  SELECT COUNT(1) INTO nuConta
  FROM dba_scheduler_jobs
  WHERE job_name = 'JOB_NOTAS_FACTELECGEN'
   AND owner = 'ADM_PERSON';
  IF nuConta = 0 THEN
      DBMS_SCHEDULER.create_job (
        job_name        => 'ADM_PERSON.JOB_NOTAS_FACTELECGEN',
        job_type        => 'PLSQL_BLOCK',
        job_action      => 'BEGIN pkg_UtilFacturacionElecGen.prCrearProcMasivoNotas; END;',
        start_date      => SYSTIMESTAMP,
        repeat_interval => 'freq=MINUTELY; interval=30',
        enabled         => TRUE,
        auto_drop      => FALSE);
  END IF;
END;
/