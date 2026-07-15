select susccodi  "Contrato" , susccemf , susccemd, susccoem
from suscripc
where susccodi = 17179188 ;
 
 select sesususc "Contrato" , sesunuse "Producto" , sesuserv "Tipo_producto" ,
 sesucate || ' - ' || Initcap(su.sucadesc) "Categoria"   ,sesusuca "Subcategoria", sesuesco "Estado de corte",coecfact "Facturable?", sesuesfn "Estado financiero",susccemf , susccemd, susccoem
from servsusc
left join categori on sesucate = catecodi
left join subcateg su on sucacate = sesucate and su.sucacodi= sesusuca
left join confesco on sesuesco = coeccodi and coecserv =sesuserv
left join suscripc on susccodi=sesususc 
where  coecfact='S' and sesucate in (6,7,9,10,14) and sesuserv in (7014)   ; 

--VALIDACIONFINAL 
 select sesususc "Contrato" , sesunuse "Producto" , sesuserv "Tipo_producto" ,
 sesucate || ' - ' || Initcap(su.sucadesc) "Categoria"   ,sesusuca "Subcategoria", sesuesco "Estado de corte",coecfact "Facturable?", sesuesfn "Estado financiero",susccemf , susccemd, susccoem
from servsusc
left join categori on sesucate = catecodi
left join subcateg su on sucacate = sesucate and su.sucacodi= sesusuca
left join confesco on sesuesco = coeccodi and coecserv =sesuserv
left join suscripc on susccodi=sesususc 
where sesunuse = 1999622  ; 

--ORDENES 
select or_order_activity.subscription_id  "Contrato",
       or_order_activity.product_id  "Producto",
       servsusc.sesucicl  "Ciclo",
       or_order_activity.package_id  "Solicitud",
       mo_packages.package_type_id || ' :  ' || ps_package_type.description as "Tipo de solicitud",
       mo_packages.motive_status_id || ' :  ' || ps_motive_status.description as "Estado solicitud",
       or_order.order_id  "Orden",
       or_order.task_type_id ||' : '|| initcap(or_task_type.description)  "Tipo de trabajo",
       or_order_activity.activity_id ||' : '|| initcap(ge_items.description)  "Actividad",
       or_order.order_status_id ||' : '|| or_order_status.description  "Estado",       
       or_order.causal_id ||' : '|| initcap(ge_causal.description)  "Causal",
       ge_causal.class_causal_id  ||' : '|| initcap( ge_class_causal.description)  "Clase causal",or_order.legalization_date 
from open.or_order
left join open.or_order_activity on or_order_activity.order_id = or_order.order_id
left join open.or_task_type on or_task_type.task_type_id = or_order.task_type_id
left join open.ge_items on ge_items.items_id = or_order_activity.activity_id
left join open.or_order_status on or_order_status.order_status_id = or_order.order_status_id
left join open.mo_packages on mo_packages.package_id = or_order_activity.package_id
left join open.ps_package_type on ps_package_type.package_type_id = mo_packages.package_type_id
left join open.ps_motive_status on ps_motive_status.motive_status_id = mo_packages.motive_status_id
left join open.servsusc on servsusc.sesunuse = or_order_activity.product_id
left join open.ge_causal on or_order.causal_id =ge_causal.causal_id 
left join open.ge_class_causal on ge_class_causal.class_causal_id =ge_causal.class_causal_id 
where sesunuse = 1999622
and or_order.task_type_id in (12622) and or_order.legalization_date   >= '22/09/2023'
AND    or_order.order_status_id in (8);
