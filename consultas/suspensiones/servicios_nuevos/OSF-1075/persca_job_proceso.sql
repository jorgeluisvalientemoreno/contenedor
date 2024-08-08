Select p.process_schedule_id, p.executable_id, p.start_date_, p.status, p.job, p.parameters_, p.log_user
From open.ge_process_schedule p
Where p.what like '%PERSCA%'
and   p.start_date_ >= to_date ('26/10/2023 08:10:00') --and p.start_date_ < to_date ('3/06/2023 08:10:00')
order by p.start_date_ desc;

Select *
From open.estaprog p
Where p.esprfein >= to_date ('26/10/2023 08:10:00')-- and p.esprfein < to_date ('3/06/2023 08:10:00')
and   p.esprprog like '%PERSCA%'
order by p.esprfefi desc;

/*select * from dba_jobs where job=3223131;
select * from dba_jobs_running WHERE JOB=3223131;
select * from dba_jobs_running_rac WHERE JOB=3223131;
SELECT * FROM DBA_SCHEDULER_RUNNING_JOBS;

select s.sarecicl, count (s.saresesu)
from open.LDC_SUSP_AUTORECO s
where s.sareproc = 7
group by s.sarecicl
order by count (s.saresesu) desc;*/

