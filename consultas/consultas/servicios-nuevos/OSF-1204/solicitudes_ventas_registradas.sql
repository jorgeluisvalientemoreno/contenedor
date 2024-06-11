with base as(select p.package_id, p.package_type_id, p.motive_status_id, p.user_id
from open.mo_packages p
where p.package_type_id =323
  and p.user_id ='INNOVACION'
  AND p.motive_status_id=13),
base2 as(
select m.product_id,
       m.product_type_id,
       base.package_type_id,
       base.package_id,
       m.motive_id,
       base.motive_status_id,
       base.user_id     
from base
inner join open.mo_motive m on m.package_id=base.package_id and product_type_id=7014),
base3 as(
select base2.*,
       o.order_id,
       o.task_type_id,
       o.order_status_id
from base2
inner join open.or_order_activity a on a.package_id=base2.package_id and a.motive_id=base2.motive_id and a.product_id = base2.product_id and a.task_type_id=12150 
inner join open.or_order o on o.order_id=a.order_id and o.task_type_id=12150 and o.order_status_id=5
inner join open.pr_product p on  p.product_id = a.product_id and p.product_status_id=15
inner join open.servsusc s on s.sesunuse=a.product_id and s.sesuesco=96
)
select *
from base3
where  exists
(select null 
from open.or_order_activity a, or_order  o 
where motive_id=base3.motive_id and a.product_id = base3.product_id and a.order_id = o.order_id and o.task_type_id in (12149, 12162, 10500,10273) and o.order_status_id in (0,5,7,11))
