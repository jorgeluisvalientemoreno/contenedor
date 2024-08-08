--fidf
select *
from estaprog  ep
where esprprog like 'FIDF%'
and   ep.esprpefa in (111230)
order by esprfein desc;

--pecofact

select * 
from open.ldc_pecofact 
where pcfapefa= 111230;

--programación pecofact
  select  o.object_id, o.name_, o.description, s.status, s.job, s.log_user, s.start_date_, s.process_schedule_id, s.frequency
from OPEN.GE_PROCESS_SCHEDULE s,open.ge_object o
where parameters_ like 'OBJECT_ID='||O.OBJECT_ID
 AND O.OBJECT_ID = 121637
 order by s.start_date_ desc




