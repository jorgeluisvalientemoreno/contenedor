--Valida la programación del job
select sysdate,j.* from user_scheduler_jobs j
where job_name like 'LDC_REPROCESA_ORDEN_CM%';

--Valida la ejecucion del job
select * from dba_scheduler_job_run_details
where job_name like 'LDC_REPROCESA_ORDEN_CM%';

--Log y estado del job
select * 
from ldc_osf_estaproc
where ano = 2023
and mes = 6
and proceso like 'LDCREPROORDENCM'
order by fecha_inicial_ejec desc;
