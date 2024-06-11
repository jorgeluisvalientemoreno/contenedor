select or_order_activity.subscription_id  "Contrato",
       or_order_activity.product_id  "Producto",
       servsusc.sesucicl  "Ciclo",
       or_order.order_id  "Orden",
       or_order.task_type_id ||' : '|| initcap(or_task_type.description)  "Tipo de trabajo",
       or_order_activity.activity_id ||' : '|| initcap(ge_items.description)  "Actividad",
       or_order.order_status_id ||' : '|| or_order_status.description  "Estado",
       ab_address.address "Direccion",
       or_order.external_address_id ,
       or_order_activity.address_id ,
       or_extern_systems_id.address_id ,
       or_order.legalization_date   "Fecha de legalizacion"
from open.or_order
left join open.or_order_activity on or_order_activity.order_id = or_order.order_id
left join open.or_task_type on or_task_type.task_type_id = or_order.task_type_id
left join open.ge_items on ge_items.items_id = or_order_activity.activity_id
left join open.or_order_status on or_order_status.order_status_id = or_order.order_status_id
left join open.mo_packages on mo_packages.package_id = or_order_activity.package_id
left join open.ps_package_type on ps_package_type.package_type_id = mo_packages.package_type_id
left join open.ps_motive_status on ps_motive_status.motive_status_id = mo_packages.motive_status_id
left join open.servsusc on servsusc.sesunuse = or_order_activity.product_id
left join or_extern_systems_id  on or_extern_systems_id.order_id =  or_order.order_id
left join ab_address  on or_order_activity.address_id = ab_address.address_id
where sesunuse= 6096768
and or_order.task_type_id in (12619) 
AND    or_order.order_status_id in (0,5)