select s.subscription_id,
       s.product_id,
       m.address_id,
       m.package_id,
       m.package_type_id,
       m.motive_status_id,
       a.order_id,
       a.task_type_id,
       a.status,
       a.operating_unit_id
from open.mo_packages m 
left join open.mo_motive s on s.package_id = m.package_id
left join open.or_order_activity a on s.subscription_id = a.subscription_id
where s.subscription_id=67257621
