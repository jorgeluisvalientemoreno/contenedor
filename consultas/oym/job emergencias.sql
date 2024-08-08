select s.process_schedule_id, s.start_date_, o.description, j.*
from OPEN.GE_PROCESS_SCHEDULE s,open.ge_object o, dba_jobs j
--where job=88208
--where process_schedule_id=51053
--where process_schedule_id=120677
where parameters_ like 'OBJECT_ID='||O.OBJECT_ID
  and o.object_id=53824
  --and s.job=369543
  and j.job=s.job;



select *
from open.ge_object
where object_id=369543;
