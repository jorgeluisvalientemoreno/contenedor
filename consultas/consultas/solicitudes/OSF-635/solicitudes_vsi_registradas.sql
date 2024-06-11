select or_order_activity.subscription_id    Suscripcion,
       or_order_activity.product_id         Producto,
       mo_packages.package_type_id    Tipo_Solicitud,
       ps_package_type.description       Desc_Tipo_Solicitud,
       mo_packages.package_id         Solicitud,
       mo_packages.comment_           obs_solicitud,
       request_date ,
       mo_packages.motive_status_id   Estado_Solicitud,
       or_order.order_id           Orden,
       or_order.task_type_id       Tipo_Trabajo,
       or_order.order_status_id    Estado_OT,
       or_order_activity.activity_id        Actividad,
       ge_items.description        Desc_Actividad,
       or_order.operating_unit_id  Unidad_Opertativa,
       mo_packages.comment_           Comentario
  from open.mo_packages 
  left join open.ps_package_type  on ps_package_type.package_type_id = mo_packages.package_type_id
  left join open.or_order_activity on mo_packages.package_id = or_order_activity.package_id
  left join open.or_order  on or_order_activity.order_id = or_order.order_id  
  left join open.servsusc  on or_order_activity.product_id = servsusc.sesunuse
  left join open.pr_product  on or_order_activity.product_id = pr_product.product_id
  left join open.ps_product_status  on ps_product_status.product_status_id = pr_product.product_status_id
  left join open.ge_items  on or_order_activity.activity_id = ge_items.items_id 
where mo_packages.package_type_id = 100101
and or_order_activity.product_id  = 1137163
and mo_packages.motive_status_id = 13
order by request_date desc
