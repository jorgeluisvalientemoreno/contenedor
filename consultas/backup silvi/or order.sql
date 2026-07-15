-- Busqueda de ordenes
  SELECT t.subscription_id , t.product_id, o.order_id , o.task_type_id  ,exec_initial_date, 
       execution_final_date , o.order_status_id as Status, o.created_date
  FROM or_order o
  INNER JOIN or_order_activity t on o.order_id = t.order_id
  WHERE  o.task_type_id in (12521) /* AND  
  o.created_date > '18/07/2022'*/
 AND  o.order_status_id = 0
-- AND  t.product_id in (31000029,17242058,17096195,50741430) 
ORDER BY o.created_date DESC ;
   
 
select *
from or_order_activity 
where task_type_id in (12151)
--and a.product_id in (17209294)
and status NOT in ('R')
order by register_date desc;

SELECT t.subscription_id , t.product_id, o.order_id , o.task_type_id ,o.created_date,exec_initial_date, 
       execution_final_date , o.order_status_id as Status
  FROM or_order o
  INNER JOIN or_order_activity t on o.order_id = t.order_id
  WHERE  o.task_type_id = 12521
  AND o.order_status_id in (8)
  AND o.created_date > '19/07/2022'
  AND o.order_id = 246494037
  ORDER BY o.created_date DESC


/*for update;
*/
select subscriber_id , subscription_id, product_id , order_id, status
from or_order_activity 
where  order_id = 243259569 ;

select *
from mo_packages p
where package_type_id = 100306;


Select *
From ldc_plazos_cert t
Where t.id_producto in (17209811)


select * 
from or_order_comment o
where o.order_id =243259569

select order_id, subscriber_id , order_status_id 
from or_order 
where order_id =246494037;

select *
from or_order_stat_change r
where r.order_id = 246494037
order by stat_chg_date desc;



LDCANOTPER
