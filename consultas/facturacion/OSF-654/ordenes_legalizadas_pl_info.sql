   select c.cosssesu  ,
       c.cosspefa ,
       c.cosspecs ,
       c.cosscoca ,
       c.cossfere ,
       ac.legalization_date ,
       ac.task_type_id ,
       c.cossmecc ,
       c.cossidre ,
       c.cosscavc ,
       ac.order_id  ,
       ac.value1 ,
       ac.value2,
       ac.exec_initial_date , 
       ac.execution_final_date 
from open.conssesu@osfpl c
inner join open.perifact@osfpl p on p.pefacodi=c.cosspefa and p.pefaano=2022 and p.pefames=10 and trunc(c.cossfere) between trunc(p.pefafimo) and trunc(p.pefaffmo)
inner join open.pericose@osfpl ct on ct.pecscons=c.cosspecs
left join( select o.order_id, o.task_type_id, o.legalization_date, a.product_id, a.value1, a.value2 ,o.exec_initial_date  , o.execution_final_date
           from open.or_order_activity@osfpl a
           inner join open.or_order@osfpl o on o.order_id=a.order_id
           and o.task_type_id in (12617, 10043,12619)
          ) ac  on ac.product_id=c.cosssesu and to_char(ac.legalization_date,'dd/mm/yyyy hh24:mi')= to_char(c.cossfere,'dd/mm/yyyy hh24:mi')
where c.cosspecs = 101983
 and cossmecc in (1,3)
 and cosscavc <> 9 
 and not exists(select null from open.elmesesu@osfpl e where e.emsssesu=c.cosssesu and e.emssfein between p.pefafimo and p.pefaffmo)
 
