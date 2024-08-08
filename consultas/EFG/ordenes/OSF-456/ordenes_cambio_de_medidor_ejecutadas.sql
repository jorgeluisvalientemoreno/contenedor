select a.product_id,
       a.subscription_id,
       o.task_type_id,
       t.description,
       a.package_id,
       a.activity_id,
       o.order_id,
       o.order_status_id,
       o.operating_unit_id,
       o.created_date
from or_order o
left join or_task_type t on t.task_type_id = o.task_type_id
left join or_order_activity a on a.order_id = o.order_id
Where o.task_type_id = 12139
and o.order_status_id not in (8,12)
and rownum <= 10
order by o.created_date desc;