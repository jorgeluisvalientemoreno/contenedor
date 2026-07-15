select pr.subscription_id  Contrato, pr.product_id  Producto,p.package_id solicitud,p.motive_status_id status_solicitud,
p.package_type_id,s.sesucicl  Ciclo, pr.product_type_id  Tipo_Producto,  pr.commercial_plan_id  Plan_Comercial , 
a.order_id ,  oo.order_status_id status_orden , oo.is_pending_liq 
from mo_packages  p
inner join mo_motive  m on p.package_id = m.package_id
inner join pr_product  pr on m.product_id = pr.product_id
inner join servsusc  s on s.sesunuse = pr.product_id
inner join or_order_activity a on p.package_id = a.package_id
inner join or_order oo on oo.order_id = a.order_id 
where p.package_type_id = 271
and p.motive_status_id in (13)
and p.package_id= 
and  exists ( select null from  or_order_activity a where p.package_id = a.package_id and a.status = 'F')
and  not exists ( select null from or_order oo where oo.operating_unit_id = p.operating_unit_id  and oo.is_pending_liq ='Y' )
group by   pr.subscription_id , pr.product_id ,p.package_id ,p.motive_status_id ,
p.package_type_id,p.order_id ,s.sesucicl , pr.product_type_id  ,  pr.commercial_plan_id   , 
a.order_id ,  oo.order_status_id , oo.is_pending_liq

