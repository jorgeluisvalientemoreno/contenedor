--Planes comerciales 
select a.commercial_plan_id id,
       a.description , 
       a.name,
       tag_name  
from open.cc_commercial_plan a
where a.initial_date <= sysdate
and a.final_date >= sysdate
and a.package_type_id = 587
and a.product_type_id = 7014 
and a.commercial_plan_id in ( 4 ,5 ,36 ,41 ,8 ,9 ,15 ,16 ,17,19,21) ; 
   
   
   
--Planes financieros

select pldicodi id,
       pldidesc description ,
       pldifein , 
       pldifefi  
from open.plandife
where (sysdate between pldifein and pldifefi)
and pldipmaf = 100
and pldicodi in ( 23,24,26,28,31,64,142)
order by pldicodi;