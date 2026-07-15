select  a.product_id  Producto,a.subscription_id , pr.product_status_id  Estado_Producto, p.package_type_id  Tipo_Solicitud, p.package_id  Solicitud,
 p.motive_status_id  Estado_Solicitud, o.order_id  Orden, o.task_type_id  Tipo_Trabajo, o.order_status_id  Estado_OT, o.causal_id, 
 o.is_pending_liq , cupodocu, cupoflpa
from open.mo_packages p
inner join or_order_activity a on p.package_id = a.package_id
inner join or_order o on a.order_id = o.order_id  
inner join servsusc s on a.product_id = s.sesunuse
INNER join pr_product  pr on a.product_id  = pr.product_id
inner join ge_items i on a.activity_id = i.items_id  
inner join CUPON c on CUPODOCU  = p.package_id 
where cuposusc = a.subscription_id
and CUPODOCU  = p.package_id 
and pr.product_status_id = 15
and p.motive_status_id  = 13 
and  p.package_type_id  != 271
and p.package_id = 89829110
and cupoflpa = 'N'
--and s.sesucate = 2
/*AND O.ORDER_STATUS_ID = 5*/
--and NOT exists ( select null from or_order oo   where a.order_id = oo.order_id  and o.order_status_id = 8)
