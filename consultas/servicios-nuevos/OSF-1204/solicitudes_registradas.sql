select ms.subscription_id    Suscripcion,
       ms.product_id         Producto,
       s.Sesucico,
       p.package_type_id    Tipo_Solicitud,
       ts.description       Desc_Tipo_Solicitud,
       p.motive_status_id   Estado_Solicitud,
       p.package_id         Solicitud,
       p.user_id            Usuario,
       o.order_id           Orden,
       o.task_type_id       Tipo_Trabajo,
       a.activity_id        Actividad,
       i.description        Desc_Actividad,
       o.order_status_id    Estado_OT,
       o.operating_unit_id  Unidad_Opertativa,
       up.contractor_id,
       up.name,
       p.comment_           Comentario
  from open.mo_packages p
  inner join open.ps_package_type ts on ts.package_type_id =  p.package_type_id
  inner join mo_motive ms on ms.package_id =  p.package_id
  left join open.or_order_activity a on p.package_id = a.package_id and a.product_id = ms.product_id
  left join open.or_order o on a.order_id = o.order_id  
  left join open.servsusc s on ms.product_id = s.sesunuse
  left join open.pr_product  pr on ms.product_id = pr.product_id
  left join open.ps_product_status ep on ep.product_status_id = pr.product_status_id
  left join open.ge_items i on a.activity_id = i.items_id
  left join open.ge_causal ca on ca.causal_id = o.causal_id
  left join open.or_operating_unit up on up.operating_unit_id = o.operating_unit_id
 where p.package_type_id in (323)
 and   o.task_type_id  in (12150)
 and   o.order_status_id = 5
 and p.motive_status_id = 13
 and pr.commercial_plan_id not in (4,36,41)
 and p.user_id = 'INNOVACION'
 order by p.request_date desc
