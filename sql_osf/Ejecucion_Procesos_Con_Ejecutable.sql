select *
  from ge_process_schedule a, sa_executable b
 where a.executable_id = b.executable_id
   and b.name = 'FIDF'
 order by a.start_date_ desc
