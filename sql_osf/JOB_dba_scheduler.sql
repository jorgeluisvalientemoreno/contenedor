select /*log_date
,      job_name
,      status
,      req_start_date
,      actual_start_date
,      run_duration
*/*
from --dba_scheduler_jobs a-- 
dba_scheduler_job_run_details a
WHERE a.JOB_NAME LIKE 'BLOQUEO_ORDEN_%'
order by a.LOG_DATE desc --458078113

