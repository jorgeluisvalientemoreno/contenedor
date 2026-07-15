update or_order
set operating_sector_id = 9213
where task_type_id =10043
and order_status_id = 0
and created_date >= trunc(sysdate)
