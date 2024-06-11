select a.subscription_id    Suscripcion,
       a.product_id         Producto,
       s.Sesucico,
       pr.product_status_id  est_prod,
       p.package_type_id    Tipo_Solicitud,
       ts.description       Desc_Tipo_Solicitud,
       p.package_id         Solicitud,
       p.motive_status_id   Estado_Solicitud,
       trunc(p.request_date) Crea_Sol,
       o.order_id           Orden,
       o.task_type_id       Tipo_Trabajo,
       a.activity_id        Actividad,
       i.description        Desc_Actividad,
       o.order_status_id    Estado_OT,
       o.causal_id          Causal,
       c.description,
       c.class_causal_id,
       o.operating_unit_id  Unidad_Opertativa,
       p.comment_           Comentario
  from open.mo_packages p
  inner join open.ps_package_type ts on ts.package_type_id =  p.package_type_id
  inner join mo_motive ms on ms.package_id =  p.package_id
  left join open.or_order_activity a on p.package_id = a.package_id
  left join open.or_order o on a.order_id = o.order_id  
  left join open.servsusc s on ms.product_id = s.sesunuse
  left join open.pr_product  pr on ms.product_id = pr.product_id
  left join open.ps_product_status ep on ep.product_status_id = pr.product_status_id
  left join open.ge_items i on a.activity_id = i.items_id
  left join open.ge_causal c on c.causal_id = o.causal_id
 where ms.product_id  in (17023346)
 and  p.motive_status_id = 13
 order by p.request_date desc
