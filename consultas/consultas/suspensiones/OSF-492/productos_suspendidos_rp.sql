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
inner join open.or_order_activity a on a.order_id= o.order_id
inner join open.pr_prod_suspension  s on s.product_id = a.product_id
inner join open.pr_product pr on pr.product_id = s.product_id
inner join open.mo_packages mp on a.package_id = mp.package_id 
where a.subscription_id = pr.subscription_id 
and s.active = 'Y'
and pr.product_type_id = 7014
and s.suspension_type_id in (101,102,103,104)
and mp.package_type_id in (265,266,100270,100156,100246,100153,100014,100237,100013,100294,100295,100321,100293,100312)
and mp.motive_status_id in (13)
