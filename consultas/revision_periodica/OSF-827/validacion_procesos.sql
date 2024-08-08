select *
from estaprog  e
where e.esprpefa = 101942;

select *
from ge_process_schedule  p
where p.start_date_ >= '09/02/2023'
--and   p.parameters_ like '%PEFACODI=101942%'
order by p.start_date_ desc;

select *
from sa_executable  s
where s.executable_id = 5549;

select *
from  DBA_SCHEDULER_JOBS  
where upper(comments ) like '%TRANSITORIA%';

SELECT LAST_START_DATE ,next_run_date,state,start_date,state,owner,job_name
FROM DBA_SCHEDULER_JOBS 
WHERE job_name = 'GEN_NOTAS_USU_TARIFA_TRANSIT';

GEN_NOTAS_USU_TARIFA_TRANSIT
