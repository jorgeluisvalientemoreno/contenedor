--select * from dba_jobs_running;-- where job = 1564314;
select *
  from dba_jobs
 where upper(what) like upper('%LDC_PRJOBINTERACCIONSINFLUJO%')
 order by 1 desc;
--select * from dba_jobs where job= 1564401;
--select * from servsusc s where s.sesunuse = 6500086
--JOB Corriendo
select *
  from dba_jobs_running a
 where a.JOB not in (299773, 465731, 393253, 64124)
 order by 1 desc;
--JOB DATA
select *
  from dba_jobs a
 where a.job in
       (select a1.JOB
          from dba_jobs_running a1
         where a.JOB not in (299773, 465731, 393253, 64124));
--JOB en TAREAS PROGRAMDAS OSF
select sysdate, b.*
  from open.GE_PROCESS_SCHEDULE b
 ORDER BY B.Start_Date_ DESC;
--select * from dba_scheduler_job_run_details;

select sysdate, a.*
  from dba_scheduler_jobs a
 where upper(a.JOB_ACTION) LIKE '%LDC_PRJOBINTERACCIONSINFLUJO%';
select *
  from ALL_SCHEDULER_JOBS a
 where job_name = 'LDC_PRJOBINTERACCIONSINFLUJO';
select * 
  from USER_SCHEDULER_JOBS a
 where job_name = 'LDC_PRJOBINTERACCIONSINFLUJO';

select /*log_date
,      job_name
,      status
,      req_start_date
,      actual_start_date
,      run_duration
*/
 *
  from dba_scheduler_job_run_details
 WHERE JOB_NAME LIKE '%LDC_PRJOBINTERACCIONSINFLUJO%';

select * from dba_jobs a where a.LOG_USER = 'OPEN'
