select sesususc , sesunuse,  sesufein , sesuesco , sesucico 
from servsusc 
/*left join pr_product on sesunuse = product_id */
where sesususc  =67339269 /* sesususc in(67339275 ,67339269 ,67339242 ,67339236,67339239,67339245,67339251 ,67339254 ,67339257 ,67339260, 67339263)*/
for update 
  
select servcodi ,servdesc , servdimi 
from servicio 
where servcodi = 7014 


select *
from feullico 
where felisesu = 52510512

select *
from lectelme
where leemsesu = 52510518
/*and leempefa =102663*/
order by leemfele desc
for update 
  
select *
from conssesu c
where c.cosssesu = 52510518

select order_id ,task_type_id ,legalization_date  
from or_order
where order_id in (263302582,263302562)
