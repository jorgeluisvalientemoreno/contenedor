--validar_ejecucion_jobs
select *
from ge_process_schedule s, sa_executable e
where s.EXECUTABLE_ID=e.executable_id
  and e.name='LDC_PROCINCLUMAS'
    ORDER BY start_date_ desc;
    
select *
from ge_process_schedule s, sa_executable e
where s.EXECUTABLE_ID=e.executable_id
  and e.name='CASCA'
    ORDER BY start_date_ desc;
