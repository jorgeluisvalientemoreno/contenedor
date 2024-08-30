select *
from Dba_Scheduler_Jobs
where owner='ADM_PERSON'
 and job_name like '%ELEC%'