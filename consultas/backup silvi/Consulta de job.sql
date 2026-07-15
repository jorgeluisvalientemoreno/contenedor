select *
from ge_process_schedule s, sa_executable e
where s.EXECUTABLE_ID=e.executable_id
  and e.name='FGCA'
    ORDER BY start_date_ desc


select sysdate, a.* from dba_jobs  a where a.JOB = 5153

select  o.object_id, o.name_, o.description, s.status, s.job, s.log_user, s.start_date_, s.process_schedule_id
from open.ge_process_schedule s,open.ge_object o
where parameters_ like 'OBJECT_ID='||O.OBJECT_ID
and s.start_date_>= '11/10/2022  11:00:00'
and o.object_id = 506545
