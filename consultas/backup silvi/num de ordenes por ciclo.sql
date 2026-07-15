select sesucicl , (count (distinct a.order_id)) num_ordenes
from or_order r
left join or_order_activity a  on a.order_id = r.order_id
left join servsusc on a.product_id = sesunuse 
where r.task_type_id in (12619)
and r.order_status_id  in (0,5) AND R.CREATED_DATE>='01/01/2024' 
group by sesucicl 
order by num_ordenes desc 

