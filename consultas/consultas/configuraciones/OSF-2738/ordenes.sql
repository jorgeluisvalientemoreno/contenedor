select or_order_activity.subscription_id  "Contrato", 
       or_order_activity.product_id  "Producto", 
       servsusc.sesucicl  "Ciclo", 
       or_order.order_id  "Orden", mo_packages.package_id,
       or_order.task_type_id ||' : '|| initcap(or_task_type.description)  "Tipo de trabajo",
       or_order_activity.activity_id ||' : '|| initcap(ge_items.description)  "Actividad", 
       or_order.order_status_id ||' : '|| or_order_status.description  "Estado",
       or_order.legalization_date   "Fecha de legalizacion",
       or_order.created_date "Fecha de creacion"
from open.or_order
left join open.or_order_activity on or_order_activity.order_id = or_order.order_id
left join open.or_task_type on or_task_type.task_type_id = or_order.task_type_id
left join open.ge_items on ge_items.items_id = or_order_activity.activity_id
left join open.or_order_status on or_order_status.order_status_id = or_order.order_status_id
left join open.mo_packages on mo_packages.package_id = or_order_activity.package_id
left join open.ps_package_type on ps_package_type.package_type_id = mo_packages.package_type_id
left join open.ps_motive_status on ps_motive_status.motive_status_id = mo_packages.motive_status_id
left join open.servsusc on servsusc.sesunuse = or_order_activity.product_id
where  mo_packages.package_id= 213191986 --and or_order.task_type_id in (11056, 11230, 11231, 11232, 11177 , 11178)
and or_order.order_status_id in (8);