select a.product_id, o.order_id, o.task_type_id, o.order_status_id, o.created_date, o.operating_unit_id, m.suspension_type_id
from or_order  o
inner join or_order_activity  a  on a.order_id = o.order_id
left join ldc_marca_producto  m  on m.id_producto = a.product_id
where o.task_type_id = 10795
and   o.order_status_id = 5
and    m.suspension_type_id in (103)
and   o.order_id = 262421069
