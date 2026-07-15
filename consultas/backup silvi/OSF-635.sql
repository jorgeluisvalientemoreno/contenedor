select a.subscription_id    Suscripcion,
       a.product_id         Producto,
       p.package_type_id    Tipo_Solicitud,
       ts.description       Desc_Tipo_Solicitud,
       p.package_id         Solicitud,
       p.comment_           obs_solicitud,
       request_date ,
       p.motive_status_id   Estado_Solicitud,
       o.order_id           Orden,
       o.task_type_id       Tipo_Trabajo,
       o.order_status_id    Estado_OT,
       a.activity_id        Actividad,
       i.description        Desc_Actividad,
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
where p.package_type_id = 100101
and a.product_id  = 1137163
and p.motive_status_id = 13
order by request_date desc
--and a.activity_id   = 4000868
--and  p.comment_ like '%OSF-635%'


--and s.Sesucico in (1850,2050,5550,9050,2401,2402)

