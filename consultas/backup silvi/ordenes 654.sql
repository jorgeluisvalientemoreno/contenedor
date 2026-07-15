select a.product_id,
       o.task_type_id,
       t.description,
       o.order_id,
       o.order_status_id,
       o.operating_unit_id,
       o.created_date,
       o.legalization_date
from or_order o
inner join or_task_type t on o.task_type_id = t.task_type_id
left join or_order_activity a on a.order_id = o.order_id
left join or_requ_Data_value da on da.order_id = o.order_id
left join open.ge_causal c on c.causal_id = o.causal_id
left join or_order_person p on p.order_id= o.order_id
left join ge_person pe on pe.person_id = p.person_id
Where a.product_id in (50788163)
and o.task_type_id in (12486)
and o.order_status_id in (0,5)
and o.created_date > '24/03/2023 16:55:00'
--and  o.legalization_date >'09/03/2023'
order by a.product_id desc 
