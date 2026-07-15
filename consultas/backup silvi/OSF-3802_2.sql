select *
from mo_packages  m
where m.package_type_id=100229
and m.motive_status_id= 13
and exists ( select null
             from or_order_activity a
             where m.package_id=a.package_id
             and status='R'
             and a.task_type_id in ( 10495 , 12154 ))
ORDER BY REQUEST_DATE DESC 
