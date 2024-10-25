--Valida la programación del job GCORECA
select *
from ge_process_schedule s, sa_executable e
where s.EXECUTABLE_ID=e.executable_id
  and e.name='GCORECA'
    ORDER BY start_date_ desc;
