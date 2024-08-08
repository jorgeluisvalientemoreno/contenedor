select p.product_id Producto,
       p.subscription_id,
       open.ldc_getedadrp(p.product_id) edad_rp,
       p.product_status_id Estado_Producto,
       s.sesuesco Estado_Corte,
       s.sesuesfn Estado_Financiero,
       s2.suspeNsion_type_id Tipo_Suspension,
       s2.active Suspension_Activa,
       a.task_type_id tipo_Trabajo,
       a.activity_id Actividad_Suspension,
       it.description Desc_Actividad_Suspension,
       a.register_date Fecha_Registro
  from open.pr_product p
  inner join open.pr_prod_suspeNsion s2 on s.sesunuse = p.product_id    
  inner join open.servsusc s on s2.product_id = p.product_id 
  inner join open.or_order_Activity  a on a.order_activity_id = p.suspen_ord_act_id
  inner join open.ge_items it on it.items_id = a.activity_id
  where product_type_id = 7014
   and p.product_status_id = 2
   and s2.suspeNsion_type_id in (14)
   and s2.active = 'Y'
