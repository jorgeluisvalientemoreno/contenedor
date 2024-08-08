select sesucicl,sesuesco, sesuesfn , pr.product_status_id,sesucate, sesusuca,ab_address.geograp_location_id ,pr.product_id ,a.order_id ,order_activity_id 
from or_order r
left join or_order_activity a  on a.order_id = r.order_id
left join servsusc on a.product_id = sesunuse 
left join pr_product pr on pr.product_id = a.product_id 
left join open.ab_address  on ab_address.address_id = pr.address_id
where r.task_type_id in (12617,10043)
and r.order_status_id  in (0,5)
and sesucicl =5474 
and not exists (select null from hicoprpm p where p.hcppsesu=sesunuse and p.hcppcopr>0 and p.hcpptico=1 )