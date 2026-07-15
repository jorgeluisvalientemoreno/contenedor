select *
from  DBA_SCHEDULER_JOBS  
where upper(comments ) like '%TRANSITORIA%';

SELECT LAST_START_DATE ,next_run_date,state,start_date,state,owner,job_name
FROM DBA_SCHEDULER_JOBS 
WHERE job_name = 'GEN_NOTAS_USU_TARIFA_TRANSIT';

