select a.subscription_id    Suscripcion,
       a.product_id         Producto,
       s.Sesucico,
       s.sesuesco,
       pr.product_status_id Estado_Producto,
       ep.description       desc_estado_Producto,
       p.package_type_id    Tipo_Solicitud,
       ts.description       Desc_Tipo_Solicitud,
       p.package_id         Solicitud,
       p.motive_status_id   Estado_Solicitud,
       p.request_date       Fecha_Creacion_Solicitud,
       o.order_id           Orden,
       o.created_date       Fecha_Creacion_Orden,
       o.task_type_id       Tipo_Trabajo,
       a.activity_id        Actividad,
       i.description        Desc_Actividad,
       o.order_status_id    Estado_OT,
       o.operating_unit_id  Unidad_Opertativa,
       p.comment_           Comentario
  from open.mo_packages p
  left join open.ps_package_type ts on ts.package_type_id = p.package_type_id
  left join open.or_order_activity a on p.package_id = a.package_id
  left join open.or_order o on a.order_id = o.order_id  
  left join open.servsusc s on a.product_id = s.sesunuse
  left join open.pr_product  pr on a.product_id = pr.product_id
  left join open.ps_product_status ep on ep.product_status_id = pr.product_status_id
  left join open.ge_items i on a.activity_id = i.items_id 
  where a.product_id = 51422104
  and   p.motive_status_id = 13
  order by p.request_date desc;
