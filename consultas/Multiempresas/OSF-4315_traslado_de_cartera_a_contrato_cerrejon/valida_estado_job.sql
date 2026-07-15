select *
from open.estaproc  e
where e.proceso like '%JOB_TRAS_DIFE_RP_RESI_CERREJON%'
 and  e.fecha_inicial_ejec  >= '20/08/2025'
order by e.fecha_inicial_ejec DESC;

/*select *
from dba_scheduler_jobs
where job_name in ('JOB_TRAS_DIFE_RP_RESI_CERREJON')*/
