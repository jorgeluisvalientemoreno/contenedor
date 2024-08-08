--Valida la programación del job
select sysdate,j.STATE
from user_scheduler_jobs j
where job_name like 'JOB_AGRUPAOTTITR%';

--Valida la ejecucion del job agrupa tipo de trabajo
select * 
from dba_scheduler_job_run_details dj
where job_name like 'JOB_AGRUPAOTTITR%'
order by dj.req_start_date desc;

--Valida la ejecucion del job LEORDJOB - actualiza ordenes agrupadas
select p.anio,
       p.mes,
       p.proceso,
       p.estado,
       p.fecha_inicial_ejec,
       p.fecha_final_ejec,
       ROUND((p.fecha_final_ejec - p.fecha_inicial_ejec) * (24 * 60), 0) tiempo_min,
       p.total_registro,
       p.regis_procesado,
       p.observacion,
       p.sesion,
       p.usuario_conectado
from estaproc p
where p.proceso like '%LEORDJOB%'
order by p.fecha_inicial_ejec desc;

