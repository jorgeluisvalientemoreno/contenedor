-- valida solicitudes de notificación
select count (1)
from mo_packages  p
where p.package_type_id=100246 --= 100248
and   p.request_date >= '05/06/2024'
and   p.request_date <= '07/06/2024';

-- valida motivos de notificación
select count (1)
from mo_motive  m
where m.product_motive_id = 100248
and   m.motiv_recording_date >= '05/06/2024'
and   m.motiv_recording_date <= '07/06/2024';

-- valida actividades de notificación
select count (1)
from or_order_activity  a
where a.activity_id in (4295664,100002997)
and   a.register_date >= '05/06/2024'
and   a.register_date <= '07/06/2024';

-- valida ordenes autonomas de notificación
select count (1)
from or_order_activity  a
where a.activity_id = 100008232
and   a.register_date >= '05/06/2024'
and   a.register_date <= '07/06/2024';

