Select p.process_schedule_id, p.executable_id, p.start_date_, p.status, p.job, p.parameters_, p.log_user
From open.ge_process_schedule p
Where p.what like '%PERSCA%'
and   p.parameters_ like '%COMMENT=10%'
order by p.start_date_ desc



--and   p.start_date_ >= to_date ('12/08/2020')
;

Select *
From open.estaprog p
Where p.esprfein >= to_date ('10/05/2023 11:40:00')
and   p.esprprog like '%PERSCA%'
order by p.esprfein desc;

select * from dba_jobs where job=2916638;
select * from dba_jobs_running WHERE JOB=2916638;
select * from dba_jobs_running_rac WHERE JOB=2916638;
SELECT * FROM DBA_SCHEDULER_RUNNING_JOBS;

select s.sarecicl, count (s.saresesu)
from open.LDC_SUSP_AUTORECO s
where s.sareproc = 7
group by s.sarecicl
order by count (s.saresesu) desc;


/*select *
from open.LDC_PROCESO */
select *
from open.LDC_SUSP_AUTORECO s
where s.sareproc = 9
and s.saresesu = 51603829
order by s.sarefepr desc  

-->= to_date ('27/04/2023')
--s.sareproc = 9
