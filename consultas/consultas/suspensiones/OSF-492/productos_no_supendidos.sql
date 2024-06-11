select a.subscription_id, 
       a.product_id, 
       o.order_id, 
       o.order_status_id, 
       o.task_type_id,
       s.suspension_type_id, 
       s.active,
       pr.product_status_id EST_PROD,
       mp.package_type_id ,
       mp.motive_status_id,
       mp.package_id
from   open.or_order o
inner join open.or_order_activity a on  a.order_id= o.order_id
inner join open.pr_prod_suspension  s on s.product_id = a.product_id
inner join open.pr_product pr on pr.product_id = s.product_id
inner join open.mo_packages mp on a.package_id = mp.package_id 
where  a.subscription_id = pr.subscription_id 
and pr.product_status_id <> 2 
and s.active = 'N'

