select a.product_id         Producto,
       p.package_id         Solicitud,
       p.motive_status_id   Estado_Solicitud,
       p.comment_           obs_solicitud,
       p.request_date       Fecha_Creacion_Solicitud,
       o.order_id           Orden,
       o.task_type_id       Tipo_Trabajo,
       o.order_status_id    Estado_OT,
       a.activity_id        Actividad,
       i.description        Desc_Actividad,
       so.items_id             items,
       o.operating_unit_id  Unidad_Opertativa,
       pe.person_id 
  from open.mo_packages p
  left join open.ps_package_type ts on ts.package_type_id = p.package_type_id
  left join open.or_order_activity a on p.package_id = a.package_id
  left join open.or_order o on a.order_id = o.order_id
  left join open.pr_product  pr on a.product_id = pr.product_id
  left join open.ge_items i on a.activity_id = i.items_id 
  left join or_order_items so on so.order_id = o.order_id  
  left join or_order_person pe on pe.order_id = o.order_id
  where a.product_id  = 1137163
  and p.package_type_id   = 100101
  and p.comment_    like  '%PRUEBA%'
  --and  so.items_id     = 100005194
  order by p.request_date   desc
  
