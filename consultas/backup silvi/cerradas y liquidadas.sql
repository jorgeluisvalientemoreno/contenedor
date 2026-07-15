SELECT a.subscription_id ,pr.product_id ,product_status_id , p.package_type_id  Tipo_Solicitud, p.package_id  Solicitud, p.motive_status_id  Estado_Solicitud,
 o.order_id  Orden, o.task_type_id  Tipo_Trabajo, a.activity_id  Actividad, o.order_status_id  Estado_OT,  o.is_pending_liq  liquidadas 
FROM PR_PRODUCT pr
inner join or_order_activity a on a.product_id = pr.product_id 
inner join or_order o on a.order_id = o.order_id  
inner join mo_packages p on  p.package_id = a.package_id
WHERE  p.package_type_id = 271
and p.motive_status_id in (13)
and product_status_id = 15
and  exists ( select null from or_order_activity a WHERE a.order_id = o.order_id  and o.order_status_id = 8 ) 
and not   exists ( select null from or_order_activity a WHERE a.order_id = o.order_id  and o.is_pending_liq = 'Y' ) 
--and  exists ( select null from cupon c where c.CUPOsusc = pr.subscription_id and  c.cupoflpa = 'N')






and (SELECT COUNT(DISTINCT(o.order_id))  FROM or_order o WHERE a.order_id = o.order_id AND o.is_pending_liq = 'Y') = 0
--and p.package_id = 186548698


(SELECT COUNT(DISTINCT(o.order_id))
  FROM or_order o
 inner join or_order_activity a on  a.order_id = o.order_id 
  WHERE  a.package_id = 156098437
  AND o.is_pending_liq = 'Y')

