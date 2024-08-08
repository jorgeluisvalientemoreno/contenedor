select *
  from open.ge_process_schedule s
 inner join open.sa_executable e on e.executable_id = s.executable_id
 where e.name = 'LDCACTCERT'
 order by start_date_ desc;
