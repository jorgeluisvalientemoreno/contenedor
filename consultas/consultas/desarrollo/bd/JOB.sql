select *
from OPEN.GE_PROCESS_SCHEDULE s,open.ge_object o
--where job=88208
--where process_schedule_id=51053
--where process_schedule_id=120677
where parameters_ like 'OBJECT_ID='||O.OBJECT_ID
  --and o.object_id=121630
    AND S.FREQUENCY='DI'
    AND JOB!=-1
  AND O.NAME_ LIKE UPPER('%ldci_pkgestnotiorden%')
where parameters_ like '%ldc_prFillOTREV%';


select *
from open.ge_process_schedule s, open.sa_executable e
where s.EXECUTABLE_ID=e.executable_id
  and e.name='GEMPS'
  and s.job!=-1
  AND S.FREQUENCY='DI'

select *
from OPEN.GE_PROC_SCHE_COND s
where s.process_scheduled_id=417647;
select *
from OPEN.GE_PROC_SCHE_DETAIL
where process_schedule_id=58913;
OPEN.PROCEJEC


select *
from open.ge_object
where object_id=120865
where upper(name_) like upper('%LDCI_PKMOVIVENTMATE.proConfirmarSolicitud%');
select * from dba_jobs where upper(what) like upper('ldci_pkgestnotiorden')
select * from DBA_SCHEDULER_JOBS
 where upper(job_action) like upper('%ldci_pkgestnotiorden%')
  order by JOB_NAME;
94408

select * from dba_jobs where job=85446;
select * from dba_jobs_running WHERE JOB=85446;
select * from dba_jobs_running_rac WHERE JOB=85446;
SELECT * FROM DBA_SCHEDULER_RUNNING_JOBS;


select *
from dba_scheduler_job_log l
where l.JOB_NAME='BAJAR_RECLAMOS_PQR_ESCRITAS';

select *
from dba_scheduler_job_run_details d
where d.JOB_NAME='BAJAR_RECLAMOS_PQR_ESCRITAS'
