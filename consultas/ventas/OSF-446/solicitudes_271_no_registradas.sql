select pr.product_id Producto,
       a.subscription_id,
       pr.product_status_id Estado_Producto,
       p.package_type_id Tipo_Solicitud,
       p.package_id Solicitud,
       p.motive_status_id Estado_Solicitud,
       o.order_id Orden,
       o.task_type_id Tipo_Trabajo,
       t.description,
       o.order_status_id Estado_OT,
       e.description,
       o.causal_id,
       (select cc.description || '-' || cl.class_causal_id || '-' ||
               cl.description
          from open.ge_causal cc
         inner join open.ge_class_causal cl on cl.class_causal_id = cc.class_causal_id
         where cc.causal_id = o.causal_id) Descr_Clase_Causal
  from open.mo_packages p
inner join open.mo_motive m on m.package_id = p.package_id
inner join open.or_order_activity a on p.package_id = a.package_id
inner join open.or_order o on a.order_id = o.order_id  
inner join open.or_order_status e on e.order_status_id = o.order_status_id
inner join open.or_task_type t on t.task_type_id = o.task_type_id 
left join  open.servsusc s on s.sesunuse = m.product_id
left join  open.pr_product  pr on pr.product_id = m.product_id
left join  open.ge_items i on a.activity_id = i.items_id  
 where p.motive_status_id != 13
   and p.package_type_id = 271
