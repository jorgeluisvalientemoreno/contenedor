--validar_job_persca
Select p.process_schedule_id, p.executable_id, p.start_date_, p.status, p.job, p.parameters_, p.log_user
From open.ge_process_schedule p
Where p.what like '%PERSCA%'
and   p.start_date_ >= to_date ('19/09/2024 08:10:00') 
order by p.start_date_ desc;

--validar_job_gemps
  select  o.object_id, o.name_, o.description, s.status, s.job, s.log_user, s.start_date_, sysdate, s.process_schedule_id, s.frequency
from OPEN.ge_process_schedule s,open.ge_object o
where parameters_ like 'OBJECT_ID='||O.OBJECT_ID
 AND O.OBJECT_ID = 121762
 order by s.start_date_ desc;


--validar_hilos_persca_gemps

Select *
From open.estaprog p
Where p.esprfein >= to_date ('1/10/2024 08:00:00')
and   p.esprprog like '%PERSCA%'
order by p.esprfefi desc;



