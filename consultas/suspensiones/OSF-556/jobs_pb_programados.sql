select *
  from open.ge_process_schedule s
 inner join open.sa_executable e on s.executable_id=e.executable_id
 where e.name = 'LDC_CAMBESTDLIC'
 order by start_date_ desc;
