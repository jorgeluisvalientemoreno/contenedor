DECLARE
   nuConta NUMBER;
BEGIN
  
  SELECT COUNT(1) INTO nuConta
  FROM dba_scheduler_jobs
  WHERE job_name = 'JOB_ELIMFACTURACION_ELECGEN'
   AND owner = 'ADM_PERSON';
   
  IF nuConta = 0 THEN 
      DBMS_SCHEDULER.create_job (
        job_name        => 'ADM_PERSON.JOB_ELIMFACTURACION_ELECGEN',
        job_type        => 'PLSQL_BLOCK',
        job_action      => 'BEGIN pkg_UtilFacturacionElecGen.prJobEliminarRegFactElect; END;',
        start_date      => SYSTIMESTAMP,
        comments        => 'Job que elimina registros de facturas/notas electronicas emitidas',
        repeat_interval => 'freq=DAILY; BYHOUR=22; byminute=15;',
        enabled         => TRUE,
        auto_drop      => FALSE);
  END IF;
END;
/