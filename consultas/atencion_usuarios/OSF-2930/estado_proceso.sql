--Valida la ejecucion del job
select * 
from dba_scheduler_job_run_details dj
where job_name like 'JOB_FINANCIA_DUPLICADO%'
order by dj.req_start_date desc;

