select *
from DBA_scheduler_chains
where chain_name = 'CADENA_JOBS_BACADI' ;

select *
from DBA_scheduler_programs
where program_name like '%BACADI%';

select *
from DBA_scheduler_program_args
where program_name like '%BACADI%';
select *
from DBA_scheduler_chain_steps
where chain_name = 'CADENA_JOBS_BACADI';

select *
from DBA_scheduler_chain_rules
where chain_name = 'CADENA_JOBS_BACADI';

SELECT *
FROM DBA_SCHEDULER_RUNNING_CHAINS
order by start_date desc;
