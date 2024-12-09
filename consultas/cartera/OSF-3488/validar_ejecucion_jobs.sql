--validar_ejecucion_jobs
select *
from ge_process_schedule s, sa_executable e
where s.EXECUTABLE_ID=e.executable_id
  and e.name='PBMAFA'
    ORDER BY start_date_ desc;
