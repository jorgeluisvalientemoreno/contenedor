select order_activity_id  "ID ORDEN", 
       order_id  "# ORDEN", 
       task_type_id  "TIPO DE TRABAJO", 
       package_id  "SOLICITUD", 
       origin_activity_id  "ID ORDEN ORIGEN"
from or_order_activity
where order_id = 246464006 or order_activity_id = 238225348