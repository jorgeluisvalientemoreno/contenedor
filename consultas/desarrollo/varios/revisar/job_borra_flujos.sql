 SELECT job_name, state, sysdate-j.last_start_date
 FROM DBA_SCHEDULER_JOBS j
 where JOB_NAME  like  'JOB_BORRA_FLUJO%';
