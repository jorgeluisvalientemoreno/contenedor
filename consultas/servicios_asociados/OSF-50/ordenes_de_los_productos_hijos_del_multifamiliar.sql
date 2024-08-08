select a.subscription_id  Suscripcion, 
       a.product_id  Producto, 
       o.order_status_id  Estado_OT, 
       p.package_type_id  Tipo_Solicitud, 
       o.order_id  Orden, 
       o.created_date  Fecha_Creacion_Orden, 
       o.task_type_id  Tipo_Trabajo, 
       a.activity_id  Actividad, 
       i.description  Desc_Actividad, 
       o.operating_unit_id  Unidad_Opertativa, 
       p.comment_  Comentario
from open.mo_packages p
inner join open.or_order_activity a on p.package_id = a.package_id
inner join open.or_order o on a.order_id = o.order_id  
inner join open.servsusc s on a.product_id = s.sesunuse
inner join open.pr_product  pr on a.product_id = pr.product_id
inner join open.ge_items i on a.activity_id = i.items_id  
where a.product_id in (1182942,1078172,1078170,1078171)
and o.created_date >= '21/07/2022'
and a.activity_id != 4000380
order by o.created_date desc;